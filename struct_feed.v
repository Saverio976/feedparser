module feedparser

import net.html

pub struct Feed {
pub:
	feed_dom html.DocumentObjectModel
	title string
	link string
	description string
	entries []Entry
}