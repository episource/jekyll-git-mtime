# jekyll-git-mtime plugin

A Jekyll plugin that sets the page variable `page.mtime` to the time of the last commit or change.
 
## Prerequisites
The git executable must be found within PATH.

## Primary Usecase
Display the time of the last change in the page footer. Usually the time of last change shall refer to the current page, only. Regarding special pages like index or sitemap, the time of last change regarding any page shall be used instead.

## Usage
#### Set page.mtime based on the history of the current page
Per default  `page.mtime` is set to the time of the last commit related to the current page or to the page's file mtime if there are uncommited changes regarding the page.

Within any page:
```liquid
{{ page.mtime }}
```

#### Format date
The liquid filter [date](https://help.shopify.com/themes/liquid/filters/additional-filters#date) maybe used for formatting:
```liquid
{{ page.mtime | date: '%Y-%m-%d' }}
```

#### Set page.mtime based on the history of the whole site
By specifying `mtime: site` or `mtime: branch` the plugin is configured to update the `mtime`-value based on the history of the whole site. This means that `page.mtime` is set to the time of the last commit (regarding the current branch & the whole site) or to the instant of the current build ([site.time](https://jekyllrb.com/docs/variables/)) if there are uncommited changes.
```liquid
---
mtime: site
---
{{ page.mtime }}
```


#### Set page.mtime to the instant of the current build (site.time)
`page.mtime` can be set to the the instant of the current build ([site.time](https://jekyllrb.com/docs/variables/)) by specifying `mtime: build` or `mtime: site.time` in the yaml frontmatter.
```liquid
    ---
    mtime: build
    ---
    {{ page.mtime | date: '%Y-%m-%d' }}=={{ site.time | date: '%Y-%m-%d' }}
``` 
  
#### Retain other values assigned to page.mtime    
Any other value assigned to `page.mtime` other than the keywords explained above is retained:
```liquid
---
mtime: something
---
{{ page.mtime }}{% comment %} prints 'something' {% endcomment %}
```