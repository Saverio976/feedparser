module feedparser

import net.html

fn get_feed_title(document_dom html.DocumentObjectModel) string {
	mut title := document_dom.get_tag("title")[0].str()
	title = strip_tag("title", title)
	return title
}
fn get_feed_link(document_dom html.DocumentObjectModel) string {
	mut link := document_dom.get_tag("link")[0].str()
	link = strip_tag("link", link)
	return link
}