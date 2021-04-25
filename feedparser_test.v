module feedparser

fn test_parse() {
	mut newfeed := parse('https://www.francetvinfo.fr/titres.rss') or { panic(err) }
	newfeed = parse('https://www.rssboard.org/files/sample-rss-091.xml') or { panic(err) }
	assert newfeed.feed_type == 'rss'
	newfeed = parse('https://time.com/feed/atom/') or { panic(err) }
	assert newfeed.feed_type == 'atom'
}

fn test_parse_rss() {
	mut newfeed := parse_rss('https://www.rssboard.org/files/sample-rss-091.xml') or { panic(err) }
	assert newfeed.feed_type == 'rss'
}

fn test_parse_atom() {
	mut newfeed := parse_atom('https://time.com/feed/atom/') or { panic(err) }
	assert newfeed.feed_type == 'atom'
}
