# http://Bio3SS.github.io

### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: notarget

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk

##################################################################

## Content

Sources += index.md posts.html

######################################################################

# Jekyll

not:
	$(RMF) about.md feed.xml

Sources += _config.yml Gemfile _posts/ _includes/ _layouts/ css/ _sass/

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
