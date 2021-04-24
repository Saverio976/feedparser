module feedparser

import net.http
import net.html

// parse is the main entry function to parse feeds via remote url.
// It check what type of feed it is (RSS or Atom) and return Feed struct.
// If you alredy know what type feed is, see parse_rss or parse_atom instead
pub fn parse(url string) ?Feed {
	doc := get_document_dom(url) or { return none }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc)
	} else if is_atom_feed(doc) {
		return parse_atom_feed(doc)
	} else {
		return none
	}
}

// parse_rss parse RSS feed with the given url
pub fn parse_rss(url string) ?Feed {
	doc := get_document_dom(url) or { return none }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc)
	} else {
		return none
	}
	
}

// parse_atom parse Atom feed with the given url
pub fn parse_atom(url string) ?Feed {
	doc := get_document_dom(url) or { return none }
	if is_atom_feed(doc) {
		return parse_atom_feed(doc)
	} else {
		return none
	}
	
}

fn get_document_dom(url string) ?html.DocumentObjectModel {
	data := http.get_text(url)
	if data.len > 0 {
		return html.parse(data)
	} else {
		return none
	}
}