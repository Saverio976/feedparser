module feedparser

import net.html

pub struct Entry {
pub:
	feed_type string
	entry_dom html.DocumentObjectModel
mut:
	tag_search_history map[string]string
pub mut:
	title       string
	link        string
	id          string
	description string
}

// get a tag in this entry.
// get can be used to get the description, the title, the link
// but also all tag that is not set by default (pubDate, ..)
pub fn (mut entry Entry) get(tag string) string {
	this_tag := tag.to_lower()
	data := match this_tag {
		'description' { entry.description }
		'summary' { entry.description }
		'content' { entry.description }
		'id' { entry.id }
		'guid' { entry.id }
		'link' { entry.link }
		'title' { entry.title }
		else { else_part(mut entry, this_tag) }
	}
	return data
}

fn else_part(mut entry Entry, tag string) string {
	if tag in entry.tag_search_history {
		return entry.tag_search_history[tag]
	}
	data := entry.entry_dom.get_tag(tag)
	if data.len == 0 {
		entry.tag_search_history[tag] = ''
	} else {
		entry.tag_search_history[tag] = strip_tag(tag, data[0].str(), entry.feed_type)
	}
	return entry.tag_search_history[tag]
}

fn (mut entry Entry) initialize_struct() ?bool {
	entry.init_title() or { return err }
	entry.init_link() or { return err }
	entry.init_description()
	return true
}

fn (mut entry Entry) init_title() ?bool {
	list_titles := entry.entry_dom.get_tag('title')
	if list_titles.len == 0 {
		return error('Atom/RSS entry/item must have a declared title')
	}
	entry.title = strip_tag('title', list_titles[0].str(), entry.feed_type)
	return true
}

fn (mut entry Entry) init_link() ?bool {
	tag := if entry.feed_type == 'rss' { 'link' } else { 'id' }
	list_links := entry.entry_dom.get_tag(tag)
	if list_links.len == 0 {
		return error('Atom/RSS entry/item must have a declareted id/link')
	}
	entry.link = strip_tag(tag, list_links[0].str(), entry.feed_type)
	return true
}

fn (mut entry Entry) init_description() {
	mut tag := if entry.feed_type == 'rss' { 'description' } else { 'summary' }
	mut list_descriptions := entry.entry_dom.get_tag(tag)
	if entry.feed_type == 'atom' && list_descriptions.len == 0 {
		tag = 'content'
		list_descriptions = entry.entry_dom.get_tag(tag)
	}
	if list_descriptions.len == 0 {
		entry.description = ''
	} else {
		entry.description = strip_tag(tag, list_descriptions[0].str(), entry.feed_type)
	}
}
