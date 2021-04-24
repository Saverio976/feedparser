module feedparser

fn test_parse() {
	mut newfeed := parse('https://www.francetvinfo.fr/titres.rss') or { panic('something ..') }
}
