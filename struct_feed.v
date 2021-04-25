module feedparser

import net.html

pub struct Feed {
	feed_dom html.DocumentObjectModel
pub:
	title       string
	link        string
	description string
	feed_type   string
pub mut:
	entries []Entry
}
