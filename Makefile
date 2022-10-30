NAME := inception

push:
	git push origin master
	git push github master:main

.PHONY: push
