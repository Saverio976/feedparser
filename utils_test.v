module feedparser

fn test_strip_tag() {
	mut data := '<title> this is A title</title>'
	assert strip_tag('title', data, 'rss') == ' this is A title'
	data = '<link href="https://somelink.xd">'
	assert strip_tag('link', data, 'atom') == 'https://somelink.xd'
}

fn test_is_rss_feed() {
	mut newfeed := parse_rss('https://www.rssboard.org/files/sample-rss-091.xml') or { panic(err) }
	assert newfeed.feed_type == 'rss'
}

fn test_is_atom_feed() {
	mut newfeed := parse_atom('https://time.com/feed/atom/') or { panic(err) }
	assert newfeed.feed_type == 'atom'
}
