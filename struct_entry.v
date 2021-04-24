module feedparser

import net.html

pub struct Entry {
mut:
	tag_search_history map[string]string
pub:
	entry_dom html.DocumentObjectModel
pub mut:
	title       string
	link        string
	id          string
	description string
}

// get a tag in this entry.
// this can be used to get description, title, link but also not default search one
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
	return entry.tag_search_history[tag] or { entry.search_tag(tag) }
}

fn (mut entry Entry) search_tag(tag string) string {
	data := entry.entry_dom.get_tag(tag)
	if data.len == 0 {
		entry.tag_search_history[tag] = ''
	} else {
		entry.tag_search_history[tag] = strip_tag(tag, data[0].str())
	}
	return entry.tag_search_history[tag]
}
