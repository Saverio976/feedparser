module feedparser

fn test_strip_tag() {
	data := '<title> this is A title</title>'
	assert strip_tag('title', data) == ' this is A title'
}

fn test_is_rss_feed() {
	mut newfeed := parse_rss('https://www.rssboard.org/files/sample-rss-091.xml') or { panic(err) }
	assert newfeed.feed_type == 'rss'
}

fn test_is_atom_feed() {
	mut newfeed := parse_atom('https://time.com/feed/atom/') or { panic(err) }
	assert newfeed.feed_type == 'atom'
}
