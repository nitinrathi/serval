test :
	fennel -l ini.fnl tests.fnl

dev :
	nodemon --exec fennel -l ini.fnl tests.fnl

run :
	fennel -l ini.fnl -e "((. (require :main) :main))"

.PHONY: test dev run
