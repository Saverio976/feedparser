module feedparser

import net.html
import net.http
import saverio.feedparser.xmlreplacement

fn strip_tag(tag string, data string, feed_type string) string {
	mut data_strip := data
	data_strip = xmlreplacement.htmlentity_to_string(data_strip)

	if tag == 'link' && feed_type == 'atom' {
		to_keep_start := 6 + data.index('href="') or { -6 }
		link := data[to_keep_start..]
		to_keep_end := link.index('"') or { link.len }
		return link[..to_keep_end]
	}

	mut start := 1 + data.index('>') or { tag.len + 1 }
	mut end := data.len - (tag.len + 2) - 1
	data_strip = data[start..end]

	if data_strip.len >= 9 && data_strip[0..9].to_lower() == '<![CDATA[' {
		start = 9
		end = -1 + data_strip.index(']]></![cdata[') or { panic('this should not happen !') }
		data_strip = data_strip[start..end]
	}

	return data_strip
}

fn get_document_dom(url string) ?html.DocumentObjectModel {
	data := http.get_text(url)
	if data.len > 0 {
		return html.parse(data)
	} else {
		return error(err_acces_url)
	}
}

fn is_rss_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag('item').len > 0
}

fn is_atom_feed(document_dom html.DocumentObjectModel) bool {
	return document_dom.get_tag('entry').len > 0
}
