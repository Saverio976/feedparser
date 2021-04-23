module feedparser

import net.html

fn parse_rss_feed(document_dom html.DocumentObjectModel) Feed {
	newfeed := Feed{
		title: get_feed_title(document_dom)
		link: get_feed_link(document_dom)
		description: get_feed_description_rss(document_dom)
		entries: get_entries_rss(document_dom)
	}
	return newfeed
}

fn get_feed_description_rss(document_dom html.DocumentObjectModel) string {
	mut description := document_dom.get_tag("description")[0].str()
	description = strip_tag("description", description)
	return description
}

fn get_entries_rss(document_dom html.DocumentObjectModel) []Entry {
	mut entries := []Entry{}
	for item in document_dom.get_tag("item") {
		entries << Entry{
			title: get_entrie_title(item)
			link: get_entrie_link(item)
			description: get_entrie_description_rss(item)
		}
	}
	return entries
}
fn get_entrie_description_rss(entrie_tag html.Tag) string {
	mut description := html.parse(entrie_tag.str()).get_tag("description")[0].str()
	description = strip_tag("description", description)
	return description
}