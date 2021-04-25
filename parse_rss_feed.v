module feedparser

import net.html

fn parse_rss_feed(document_dom html.DocumentObjectModel) Feed {
	newfeed := Feed{
		feed_dom: document_dom
		title: get_feed_title(document_dom) // from parse_common_func.v
		link: get_feed_link(document_dom) // from parse_common_func.v
		description: get_feed_description_rss(document_dom)
		entries: get_entries_rss(document_dom)
		feed_type: 'rss'
	}
	return newfeed
}

fn get_feed_description_rss(document_dom html.DocumentObjectModel) string {
	mut description := document_dom.get_tag('description')[0].str()
	description = strip_tag('description', description)
	return description
}

fn get_entries_rss(document_dom html.DocumentObjectModel) []Entry {
	mut entries := []Entry{}
	mut entry := Entry{}
	for item in document_dom.get_tag('item') {
		entry = Entry{
			entry_dom: html.parse(item.str())
		}
		entry.title = entry.search_tag('title')
		entry.link = entry.search_tag('link')
		entry.id = entry.search_tag('guid')
		entry.description = entry.search_tag('description')
		entries << entry
	}
	return entries
}
