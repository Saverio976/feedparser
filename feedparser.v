module feedparser

import net.html

const (
	err_acces_url  = 'Url not valid or poor connection'
	err_parse_rss  = 'Document providen is not a RSS feed'
	err_parse_atom = 'Document providen is not an Atom feed'
	err_parse      = 'Document providen is not a valid type'
)

// parse is the main entry function to parse feeds via the given url.
// parse check what type of feed it is (between RSS and Atom)
// and return Feed struct.
pub fn parse(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc) or { return err }
	} else if is_atom_feed(doc) {
		return parse_atom_feed(doc) or { return err }
	} else {
		return error(.err_parse)
	}
}

// parse_rss parse RSS feed with the given url
pub fn parse_rss(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_rss_feed(doc) {
		return parse_rss_feed(doc) or { return err }
	} else {
		return error(.err_parse_rss)
	}
}

// parse_atom parse Atom feed with the given url
pub fn parse_atom(url string) ?Feed {
	doc := get_document_dom(url) or { return err }
	if is_atom_feed(doc) {
		return parse_atom_feed(doc) or { return err }
	} else {
		return error(.err_parse_atom)
	}
}

fn parse_rss_feed(document_dom html.DocumentObjectModel) ?Feed {
	mut newfeed := Feed{
		feed_dom: document_dom
		feed_type: 'rss'
	}
	newfeed.initialize_struct() or { return err }
	return newfeed
}

fn parse_atom_feed(document_dom html.DocumentObjectModel) ?Feed {
	mut newfeed := Feed{
		feed_dom: document_dom
		feed_type: 'atom'
	}
	newfeed.initialize_struct() or { return err }
	return newfeed
}
