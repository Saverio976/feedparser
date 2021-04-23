# V feedparser

## func

* parse
```v
fn parse(url string) ?Feed
// parse is the main entry function to parse feeds via remote url
// check what type of feed it is (RSS or Atom) and return Feed struct
// if you know already what type feed is, see parse_rss or parse_atom instead
```
* parse_atom
```v
fn parse_atom(url string) Feed
// parse_atom parse Atom feed with the given url
```
* parse_rss
```v
fn parse_rss(url string) Feed
// parse_rss parse RSS feed with the given url
```

## struct
* Entry
```v
struct Entry {
pub:
	title       string
	link        string
	description string
}
```
* Feed
```v
struct Feed {
pub:
	title       string
	link        string
	description string
	entries     []Entry
}
```