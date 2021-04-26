module feedparser

import net.html

pub struct Feed {
	feed_type string
	feed_dom  html.DocumentObjectModel
pub mut:
	title       string
	link        string
	description string
	entries     []Entry
}

fn (mut feed Feed) initialize_struct() ?bool {
	feed.init_title() or { return err }
	feed.init_link() or { return err }
	feed.init_description()
	feed.init_entries() or { return err }
	return true
}

fn (mut feed Feed) init_title() ?bool {
	list_titles := feed.feed_dom.get_tag('title')
	if list_titles.len == 0 {
		return error('Atom/RSS feeds must have a declareted title')
	}
	feed.title = strip_tag('title', list_titles[0].str(), feed.feed_type)
	return true
}

fn (mut feed Feed) init_link() ?bool {
	tag := if feed.feed_type == 'rss' { 'link' } else { 'id' }
	list_links := feed.feed_dom.get_tag(tag)
	if list_links.len == 0 {
		return error('Atom/RSS feeds must have a declareted id/link')
	}
	feed.link = strip_tag(tag, list_links[0].str(), feed.feed_type)
	return true
}

fn (mut feed Feed) init_description() {
	tag := if feed.feed_type == 'rss' { 'description' } else { 'subtitle' }
	list_descriptions := feed.feed_dom.get_tag(tag)
	if list_descriptions.len == 0 {
		feed.description = ''
	} else {
		feed.description = strip_tag(tag, list_descriptions[0].str(), feed.feed_type)
	}
}

fn (mut feed Feed) init_entries() ?bool {
	mut entries := []Entry{}
	tag := if feed.feed_type == 'rss' { 'item' } else { 'entry' }
	mut entry := Entry{}
	for item in feed.feed_dom.get_tag(tag) {
		entry = Entry{
			entry_dom: html.parse(item.str())
			feed_type: feed.feed_type
		}
		entry.initialize_struct() or { return err }
		entries << entry
	}
	feed.entries = entries
	return true
}
