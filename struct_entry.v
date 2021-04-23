module feedparser

import net.html

pub struct Entry {
pub:
	entry_dom html.DocumentObjectModel
pub mut:
	title string
	link string
	description string
}

// get a list of a tag and sanityze it for you. if tag not found return ""
pub fn (entry Entry) get_tag(tag string) string {
	this_tag := tag.to_lower()
	data := entry.entry_dom.get_tag(this_tag)
	if data.len == 0 {
		return ""
	}
	return strip_tag(this_tag, data[0].str())
}