# Markdown Notes

## Headings

```markdown linenums="1"
Heading 1
=========

Heading 2
---------

# Heading 1
## Heading 2
### Heading 3
```

## Text Formatting

```markdown linenums="1"
*Italic*    _Italic_
**Bold**    __Bold__

~GitHub's strike-trough~
```

## Links & Images

```markdown linenums="1"
[link text](http://b.org "title")

[link text][anchor]
[anchor]: http://b.org "title"

![alt attribute](http://url/b.jpg "title")

![alt attribute][anchor]
[anchor]: http://url/b.jpg "title"
```

```markdown linenums="1"
> Blockquote

* unordered list        - unordered list
* unordered list        - unordered list
* unordered list        - unordered list

1) ordered list         1. ordered list
2) ordered list         2. ordered list
3) ordered list         3. ordered list

- [ ] empty checkbox
- [x] checked checkbox
```

### Horizontal rule

```markdown linenums="1"
---                     ***
```

## Code

```markdown linenums="1"
`inline code`

    ```lang linenums="1"
    multi-line
    code block
    ```
```

## Table

```markdown linenums="1"
| column label | column label | column label  |
|:-------------|:------------:|--------------:|
| left-aligned | centered     | right-aligned |
| row contents | row contents | row contents  |
```
