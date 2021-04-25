module feedparser

fn test_is_module_compil() {
	mut newfeed := parse('https://www.francetvinfo.fr/titres.rss') or {
		panic('feedparse.parse func return none')
	}
	newfeed = parse_rss('https://time.com/feed/') or {
		panic('feedparse.parse_rss func return none')
	}
	newfeed = parse_atom('https://time.com/feed/atom/') or {
		panic('feedparse.parse_atom func return none')
	}
}

fn test_parse_rss() {
	mut newfeed := parse_rss('https://www.rssboard.org/files/sample-rss-091.xml') or {
		panic('feedparse.parse_rss func return none')
	}

	// Feed struct
	assert newfeed.title == 'WriteTheWeb'
	assert newfeed.link == 'http://writetheweb.com'
	assert newfeed.description == 'News for web users that write back'
	// Entry struct in the Feed struct
	assert newfeed.entries[0].title == 'Giving the world a pluggable Gnutella'
	assert newfeed.entries[0].link == 'http://writetheweb.com/read.php?item=24'
	assert newfeed.entries[0].description == 'WorldOS is a framework on which to build programs that work like Freenet or Gnutella -allowing distributed applications using peer-to-peer routing.'
}

fn test_parse_atom() {
	// mut newfeed := parse_atom() // dont find an atom fix in the web
}
