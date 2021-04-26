module feedparser

import net.html

fn parse_atom_feed(document_dom html.DocumentObjectModel) ?Feed {
	mut newfeed := Feed{
		feed_dom: document_dom
		feed_type: 'atom'
	}
	newfeed.initialize_struct() or { return err }
	return newfeed
}
