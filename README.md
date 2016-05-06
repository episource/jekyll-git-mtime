# jekyll-git-mtime plugin

A Jekyll plugin that sets the page variable `page.mtime` to the time of the last commit -or- if uncommited changes exist to the file's mtime. By explicitly setting `mtime: build` or `mtime: site.time` in a page's yaml frontmatter, the `page.mtime` variable can also be explicitly set to the current time (retrieved via [site.time](https://jekyllrb.com/docs/variables/)).

## Prerequisites
The git executable must be found within PATH.

## Usage

Within any page:
```liquid
{{ page.mtime }}
```
    
The liquid filter [date](https://help.shopify.com/themes/liquid/filters/additional-filters#date) maybe used for formatting:
```liquid
{{ page.mtime | date: '%Y-%m-%d' }}
```
    
Setting `mtime: build` or `mtime: site.time` in the yaml frontmatter sets `page.mtime` to `site.time`:
```liquid
    ---
    mtime: site.time
    ---
    {{ page.mtime | date: '%Y-%m-%d' }}=={{ site.time | date: '%Y-%m-%d' }}
```
    
Any other value assigned to `page.mtime` in the the yaml frontmatter is retained:
```liquid
---
mtime: something
---
{{ page.mtime }}{% comment %} prints 'something' {% endcomment %}
```