# V feedparser

## func

* parse
```rust
fn parse(url string) ?Feed
// parse is the main entry function to parse feeds via remote url
// check what type of feed it is (RSS or Atom) and return Feed struct
// if you know already what type feed is, see parse_rss or parse_atom instead
```
* parse_atom
```rust
fn parse_atom(url string) Feed
// parse_atom parse Atom feed with the given url
```
* parse_rss
```rust
fn parse_rss(url string) Feed
// parse_rss parse RSS feed with the given url
```

## struct
* Entry
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
```rust
fn (mut entry Entry) get(tag string) string
// get a tag in this entry.
// this can be used to get description, title, link but also not default search one
```
* Feed
```rust
struct Feed {
pub:
        feed_dom    html.DocumentObjectModel
        title       string
        link        string
        description string
pub mut:
        entries []Entry
}
```