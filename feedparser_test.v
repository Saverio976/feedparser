module feedparser

// pub fn parse
fn test_parse() {
	mut url := 'https://www.francetvinfo.fr/titres.rss'
	mut newfeed := parse(url) or { panic(err) }
	url = 'https://www.rssboard.org/files/sample-rss-091.xml'
	newfeed = parse(url) or { panic(err) }
	assert newfeed.feed_type == 'rss'
	url = 'https://time.com/feed/atom/'
	newfeed = parse(url) or { panic(err) }
	assert newfeed.feed_type == 'atom'
}

// pub fn parse_rss
fn test_parse_rss() {
	url := 'https://www.rssboard.org/files/sample-rss-091.xml'
	mut newfeed := parse_rss(url) or { panic(err) }
	assert newfeed.feed_type == 'rss'
}

// pub fn parse_atom
fn test_parse_atom() {
	url := 'https://time.com/feed/atom/'
	mut newfeed := parse_atom(url) or { panic(err) }
	assert newfeed.feed_type == 'atom'
}

// private
fn test_strip_tag() {
	mut data := '<title> this is A title</title>'
	assert strip_tag('title', data, 'rss') == ' this is A title'
	data = '<link href="https://somelink.xd">'
	assert strip_tag('link', data, 'atom') == 'https://somelink.xd'
}

// private
fn test_is_rss_feed() {
	mut newfeed := parse_rss('https://www.rssboard.org/files/sample-rss-091.xml') or { panic(err) }
	assert newfeed.feed_type == 'rss'
}

// private
fn test_is_atom_feed() {
	mut newfeed := parse_atom('https://time.com/feed/atom/') or { panic(err) }
	assert newfeed.feed_type == 'atom'
}

// public method Entry.get
fn test_entry_get() {
	mut newfeed := parse_rss('https://www.francetvinfo.fr/titres.rss') or { panic(err) }
	len_map := newfeed.entries[0].tag_search_history.len
	newfeed.entries[0].get('pubDate')
	assert newfeed.entries[0].tag_search_history.len != len_map
}
