module feedparser

import net.http
import net.html

const (
	err_acces_url  = 'Url not valid or poor connection'
	err_parse_rss  = 'Document providen is not a RSS feed'
	err_parse_atom = 'Document providen is not an Atom feed'
	err_parse      = 'Document providen is not a valid type'
)

// parse is the main entry function to parse feeds via remote url.
// It check what type of feed it is (RSS or Atom) and return Feed struct.
// If you alredy know what type feed is, see parse_rss or parse_atom instead
pub fn parse(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc)
	} else if is_atom_feed(doc) {
		return parse_atom_feed(doc)
	} else {
		return error(err_parse)
	}
}

// parse_rss parse RSS feed with the given url
pub fn parse_rss(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc)
	} else {
		return error(err_parse_rss)
	}
}

// parse_atom parse Atom feed with the given url
pub fn parse_atom(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_atom_feed(doc) {
		return parse_atom_feed(doc)
	} else {
		return error(err_parse_atom)
	}
}

fn get_document_dom(url string) ?html.DocumentObjectModel {
	data := http.get_text(url)
	if data.len > 0 {
		return html.parse(data)
	} else {
		return error(err_acces_url)
	}
}
