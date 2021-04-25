module feedparser

fn test_entry_get() {
	mut newfeed := parse_rss('https://www.francetvinfo.fr/titres.rss') or { panic(err) }
	len_map := newfeed.entries[0].tag_search_history.len
	newfeed.entries[0].get('pubDate')
	assert newfeed.entries[0].tag_search_history.len != len_map
}
