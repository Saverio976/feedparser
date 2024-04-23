import saverio976.feedparser

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
