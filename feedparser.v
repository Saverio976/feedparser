module feedparser

import net.http
import net.html

pub struct Entry {
pub:
	title string
	link string
	description string
}

pub struct Feed {
pub:
	title string
	link string
	description string
	entries []Entry
}


// parse is the main entry function to parse feeds via remote url
// check what type of feed it is (RSS or Atom) and return Feed struct
// if you know already what type feed is, see parse_rss or parse_atom instead
pub fn parse(url string) ?Feed{
	data := http.get_text(url)
	doc := html.parse(data)
	if is_rss_feed(doc) {
		return parse_rss_feed(doc)
	} else if is_atom_feed(doc) {
		return parse_atom_feed(doc)
	} else {
		return none
	}
}

// parse_rss parse RSS feed with the given url
pub fn parse_rss(url string) Feed {
	/*
	* to parse RSS feed via remote url
	*/
	data := http.get_text(url)
	doc := html.parse(data)
	return parse_rss_feed(doc)
}

// parse_atom parse Atom feed with the given url
pub fn parse_atom(url string) Feed {
	data := http.get_text(url)
	doc := html.parse(data)
	return parse_atom_feed(doc)
}