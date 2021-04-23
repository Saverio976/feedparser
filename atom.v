module feedparser

import net.html

fn parse_atom_feed(document_dom html.DocumentObjectModel) Feed {
	newfeed := Feed{
		title: get_feed_title(document_dom)
		link: get_feed_link(document_dom)
		description: get_feed_description_atom(document_dom)
		entries: get_entries_atom(document_dom)
	}
	return newfeed
}

fn get_feed_description_atom(document_dom html.DocumentObjectModel) string {
	mut description := document_dom.get_tag("subtitle")[0].str()
	description = strip_tag("subtitle", description)
	return description
}

fn get_entries_atom(document_dom html.DocumentObjectModel) []Entry {
	mut entries := []Entry{}
	for item in document_dom.get_tag("entry") {
		entries << Entry{
			title: get_entrie_title(item)
			link: get_entrie_link(item)
			description: get_entrie_description_atom(item)
		}
	}
	return entries
}
fn get_entrie_description_atom(entrie_tag html.Tag) string {
	mut tag := "summary"
	mut tags_description := html.parse(entrie_tag.str()).get_tag(tag)
	if tags_description.len == 0 {
		tag = "content"
		tags_description = html.parse(entrie_tag.str()).get_tag(tag)
	}
	mut description := tags_description[0].str()
	description = strip_tag(tag, description)
	return description
}