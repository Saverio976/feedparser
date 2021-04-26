module feedparser

import net.html

import xmlreplacement

fn strip_tag(tag string, data string, feed_type string) string {
	if tag == 'link' && feed_type == 'atom' {
		to_keep_start := 6 + data.index('href="') or { -6 }
		link := data[to_keep_start..]
		to_keep_end := link.index('"') or { link.len }
		return link[..to_keep_end]
	}
	mut to_keep_start := 1 + data.index('>') or { tag.len + 1 }
	mut to_keep_end := data.len - (tag.len + 2) - 1
	mut data_strip := data[to_keep_start..to_keep_end]

	if data_strip.len >= 9 && data_strip[0..9].to_upper() == '<![CDATA[' {
		to_keep_start = 9
		to_keep_end = -1 + data_strip.index(']]></![cdata[') or {
			panic('this should not happen !')
		}
		data_strip = data_strip[to_keep_start..to_keep_end]
	}
	for key, value in xmlreplacement.xml_replacement {
		data_strip = data_strip.replace(key, value)
	}
	return data_strip
}

fn is_rss_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag('item').len > 0
}

fn is_atom_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag('entry').len > 0
}
