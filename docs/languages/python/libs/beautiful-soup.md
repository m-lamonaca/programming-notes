# [Beautiful Soup Library](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)

## Making the Soup

```py linenums="1"

from bs4 import BeautifulSoup
import requests
import lxml  # better html parser than built-in

response = requests.get("url")  # retrieve a web page

soup = BeautifulSoup(response.text, "html.parser")  # parse HTML from response w/ python default HTML parser
soup = BeautifulSoup(response.text, "lxml")  # parse HTML from response w/ lxml parser

soup.prettify()  # prettify parsed HTML for display
```

## Kinds of Objects

Beautiful Soup transforms a complex HTML document into a complex tree of Python objects.

### Tag

A Tag object corresponds to an XML or HTML tag in the original document

```py linenums="1"
soup = BeautifulSoup('<b class="boldest">Extremely bold</b>', 'html.parser')  # parse HTML/XML

tag = soup.b
type(tag)  # <class 'bs4.element.Tag'>
print(tag)  # <b class="boldest">Extremely bold</b>

tag.name  # tag name
tag["attribute"]  # access to tag attribute  values
tag.attrs  # dict of attribue-value pairs
```

### Navigable String

A string corresponds to a bit of text within a tag. Beautiful Soup uses the `NavigableString` class to contain these bits of text.

## Navigating the Tree

### Going Down

```py linenums="1"
soup.<tag>.<child_tag>  # navigate using tag names

<tag>.contents  # direct children as a list
<tag>.children  # direct children as a generator for iteration
<tag>.descendants  # iterator over all children, recursive

<tag>.string  # tag contents, does not have further children
# If a tag's only child is another tag, and that tag has a .string, then the parent tag is considered to have the same .string as its child
# If a tag contains more than one thing, then it's not clear what .string should refer to, so .string is defined to be None

<tag>.strings  # generator to iterate over all children's strings (will list white space)
<tag>.stripped_strings  # generator to iterate over all children's strings (will NOT list white space)
```

### Going Up

```py linenums="1"
<tag>.parent  # tags direct parent (BeautifulSoup has parent None, html has parent BeautifulSoup)
<tag>.parents  # iterable over all parents
```

### Going Sideways

```py linenums="1"
<tag>.previous_sibling
<tag>.next_sibling

<tag>.previous_siblings
<tag>.next_siblings
```

### Going Back and Forth

```py linenums="1"
<tag>.previous_element  # whatever was parsed immediately before
<tag>.next_element # whatever was parsed immediately afterwards

<tag>.previous_elements  # whatever was parsed immediately before as a list
<tag>.next_elements  # whatever was parsed immediately afterwards as a list
```

## Searching the Tree

## Filter Types

```py linenums="1"
soup.find_all("tag")  # by name
soup.find_all(["tag1", "tag2"])  # multiple tags in a list
soup.find_all(function)  # based on a bool function
soup.find_all(True)  # Match everything
```

## Methods

Methods arguments:

- `name` (string): tag to search for
- `attrs` (dict): attribute-value pai to search for
- `string` (string): search by string contents rather than by tag
- `limit` (int). limit number of results
- `**kwargs`: be turned into a filter on one of a tag's attributes.

```py linenums="1"
find_all(name, attrs, recursive, string, limit, **kwargs)  # several results
find(name, attrs, recursive, string, **kwargs)  # one result

find_parents(name, attrs, string, limit, **kwargs)  # several results
find_parent(name, attrs, string, **kwargs)  # one result

find_next_siblings(name, attrs, string, limit, **kwargs)  # several results
find_next_sibling(name, attrs, string, **kwargs)  # one result

find_previous_siblings(name, attrs, string, limit, **kwargs)  # several results
find_previous_sibling(name, attrs, string, **kwargs)  # one result

find_all_next(name, attrs, string, limit, **kwargs)  # several results
find_next(name, attrs, string, **kwargs)  # one result

find_all_previous(name, attrs, string, limit, **kwargs)  # several results
find_previous(name, attrs, string, **kwargs)  # one result

soup("html_tag")  # same as soup.find_all("html_tag")
soup.find("html_tag").text  # text of the found tag
soup.select("css_selector")  # search for CSS selectors of HTML tags
```

## Modifying the Tree

### Changing Tag Names an Attributes

```py linenums="1"
<tag>.name = "new_html_tag"  # modify the tag type
<tag>["attribute"]  = "value"  # modify the attribute value
del <tag>["attribute"]  # remove the attribute

soup.new_tag("name", <attribute> = "value")  # create a new tag with specified name and attributes

<tag>.string = "new content"  # modify tag text content
<tag>.append(item)  # append to Tag content
<tag>.extend([item1, item2])  # add every element of the list in order

<tag>.insert(position: int, item)  # like .insert in Python list

<tag>.insert_before(new_tag)  # insert tags or strings immediately before something else in the parse tree
<tag>.insert_after(new_tag)  # insert tags or strings immediately before something else in the parse tree

<tag>.clear()  # remove all tag's contents

<tag>.extract()  # extract and return the tag from the tree (operates on self)
<tag>.string.extract()  # extract and return the string from the tree (operates on self)
<tag>.decompose()  # remove a tag from the tree, then completely destroy it and its contents
<tag>.decomposed  # check if tag has be decomposed

<tag>.replace_with(item)  # remove a tag or string from the tree, and replaces it with the tag or string of choice

<tag>.wrap(other_tag)  # wrap an element in the tag you specify, return the new wrapper
<tag>.unwrap()  # replace a tag with whatever's inside, good for stripping out markup

<tag>.smooth()  # clean up the parse tree by consolidating adjacent strings
```
