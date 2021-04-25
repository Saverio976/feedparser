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
	println('Feed\'s link : ${newsfeed.link}')
	println('Feed\'s description : ${newsfeed.description}')

	// print only 3 results to not spam the terminal :)
	for entry in newsfeed.entries[..2] {
		println('\nEntry\'s Title : ${entry.title}')
		println('Entry\'s Link : ${entry.link}')
		println('Entry\'s Id : ${entry.id}')
		println('Entry\'s description : ${entry.description}')
	}
}
