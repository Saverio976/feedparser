module feedparser

import net.html

fn strip_tag(tag string, data string) string {
	mut to_keep_start := tag.len + 2
	mut to_keep_end := data.len - to_keep_start - 1
	mut data_strip := data[to_keep_start..to_keep_end]
	if data_strip[0..9].to_upper() == "<![CDATA[" {
		to_keep_start = 9
		to_keep_end = data_strip.index("]]></![cdata[") or { panic("what's going on ?") }
		data_strip = data_strip[to_keep_start..to_keep_end-1]
	}
	index_to_strip := data_strip.index("&nbsp") or { -1 }
	if index_to_strip != -1 {
		data_strip = data_strip[..index_to_strip] + " " + data_strip[index_to_strip+5..]
	}
	return data_strip
}

fn is_rss_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag("item").len > 0
}

fn is_atom_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag("entry").len > 0
}