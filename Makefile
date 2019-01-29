## Local
# http://localhost:4913/
# http://localhost:4913/announce.html

## Posting
# https://avenue.cllmcmaster.ca/d2l/lms/news/newedit.d2l?ou=273939
# http://bio3ss.github.io

## Avenue main
# https://avenue.cllmcmaster.ca/d2l/home/273939

## To CP using keyboard?
## works with shift-arrows, V seems not helpful
## To get out of trappy text box, try double-tab

# make serve ##
# jekyll build

current: target
-include target.mk

##################################################################

# make files

Sources += Makefile README.md sub.mk LICENSE.md TODO.md

include sub.mk
-include $(ms)/perl.def

##################################################################

## Content

Sources += $(wildcard *.md) updates.html

Sources += $(wildcard materials/*.*)

######################################################################

## Logos

zebras.jpg:
	wget -O $@ "http://www.webmastergrade.com/wp-content/uploads/2009/09/Animal-Group-01.jpg"

zebras.crop.jpg: zebras.jpg
	convert -crop 800x440+0+60 $< $@
Sources += caribou.crop.jpg

##################################################################

dinosaur.jpg:
	wget -O $@ "https://upload.wikimedia.org/wikipedia/commons/9/92/Edmontonia_dinosaur.png"

######################################################################

## Facebook images

Ignore += caribou*.jpg
caribou.jpg:
	wget -O $@ "https://upload.wikimedia.org/wikipedia/commons/8/86/Mech_06.jpg"

caribou.crop.jpg: caribou.jpg 
	convert -crop 600x180+0+170 $< $@

Ignore += mara*.jpg
mara.jpg:
	wget -O $@ "https://upload.wikimedia.org/wikipedia/en/3/3f/Herds_Maasi_Mara_%28cropped_and_straightened%29.jpg"

mara.crop.jpg: mara.jpg Makefile
	convert -crop 966x360+0+100 $< $@

# Posts

# Posts are made from drafts as a side effect of making *.post
Sources += $(wildcard _posts/*.*)
Sources += post.pl

%.post: %.md post.pl
	$(MAKE) _posts
	$(PUSH)
	$(shell_execute)

Ignore += announce.post
announce.post: announce.md

######################################################################

## Restarting the year

Sources += 2018_posts.list
post_archive:
	git mv _posts _2018_posts
	ls _2018_posts/* > 2018_posts.list
	git rm 2017_posts.list 

_posts:
	$(mkdir)

## git rm -r materials/2016/*.* ##
Sources += $(wildcard materials/2017/*.*)
Sources += $(wildcard materials/2018/*.*)
materials_archive:
	mkdir materials/2018
	git mv materials/*.* materials/2018

## wayback deactivated

######################################################################

# Jekyll

not:
	$(RMF) about.md feed.xml

Sources += _config.yml $(wildcard Gemfile_*)

Sources += _includes/* _layouts/* css/* _sass/*

Ignore += .sass-cache/ Gemfile Gemfile.lock _site/

orig:
	$(LN) Gemfile_orig Gemfile

sb:
	$(LN) Gemfile_sb Gemfile

######################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
