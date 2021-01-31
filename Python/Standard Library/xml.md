# XML Module CheatSheet

## Submodules

The XML handling submodules are:

- `xml.etree.ElementTree`: the ElementTree API, a simple and lightweight XML processor
- `xml.dom`: the DOM API definition
- `xml.dom.minidom`: a minimal DOM implementation
- `xml.dom.pulldom`: support for building partial DOM trees
- `xml.sax`: SAX2 base classes and convenience functions
- `xml.parsers.expat`: the Expat parser binding

## xml.etree.ElementTree

```python
import xml.etree.ElementTree as ET

data = "<xml/>"

tree = ET.fromstring(data)  # parse string containing XML

tree.find("tag").text  # return data contained between <tag></tag>
tree.find("tag").get("attribute")  # return value of <tag attrubute="value">
tree.findall("tag1/tag2")  # list of tag2 inside tag1
```
