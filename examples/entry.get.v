/* Choose one of this possibility :*/
// if you installed the module in your project folder :
// uncomment the next line
//import feedparser

// if you installed the module globaly :
// uncomment the next line
//import saverio.feedparser

fn main() {
	url := 'https://rss.nytimes.com/services/xml/rss/nyt/World.xml'
	mut newsfeed := feedparser.parse(url) or { panic(err.str()) }

	println('Feed\'s title : ${newsfeed.title}')

	// print only 3 results to not spam the terminal :)
	for mut entry in newsfeed.entries[..2] {
		println('\nEntry\'s Title : ${entry.title}')
		// get a tag that is not search by default
		println('Entry\'s pubDate : ${entry.get("pubDate")}') // the returned value will always be a string
		// but get can work also for all default search
		println('Entry\'s Title : ${entry.get("title")}') // will be the same as entry.title
		/* The main difference is that the .get will check if the tag given
		 * is already a tag search by default or if the tag given has been search in the past for the same entry
		 * -> .get will keep a trace of the tag and the result */
	}
}
