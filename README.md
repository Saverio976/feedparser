# v feedparser

v module to parse RSS and Atom feed

## Install
download this repo (with git (https://github.com/Saverio976/feedparser.v.git) or with .zip)
next, there are 2 possibilities :
1) enable the module only for your project :

- put the downloaded folder in your project folder

- in your code : `import feedparser`

2) enable the module globaly :

- where are the other module installed create the folder `saverio` and put the downloaded folder in

- in your code : `import saverio.feedparser`Generating markdown in "./feedparser/feedparser.md"


# module feedparser

## Contents
- [parse](#parse)
- [parse_atom](#parse_atom)
- [parse_rss](#parse_rss)
- [Entry](#Entry)
  - [get](#get)
- [Feed](#Feed)

## parse
```rust
fn parse(url string) ?Feed
```
 parse is the main entry function to parse feeds via remote url.  It check what type of feed it is (RSS or Atom) and return Feed struct.  If you alredy know what type feed is, see parse_rss or parse_atom instead 

[[Return to contents]](#Contents)

## parse_atom
```rust
fn parse_atom(url string) ?Feed
```
 parse_atom parse Atom feed with the given url 

[[Return to contents]](#Contents)

## parse_rss
```rust
fn parse_rss(url string) ?Feed
```
 parse_rss parse RSS feed with the given url 

[[Return to contents]](#Contents)

## Entry
```rust
struct Entry {
mut:
	tag_search_history map[string]string
pub:
	entry_dom html.DocumentObjectModel
pub mut:
	title       string
	link        string
	id          string
	description string
}
```


[[Return to contents]](#Contents)

## get
```rust
fn (mut entry Entry) get(tag string) string
```
 get a tag in this entry.  this can be used to get description, title, link but also not default search one 

[[Return to contents]](#Contents)

## Feed
```rust
struct Feed {
	feed_dom html.DocumentObjectModel
pub:
	title       string
	link        string
	description string
	feed_type   string
pub mut:
	entries []Entry
}
```


[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 25 Apr 2021 20:55:06
