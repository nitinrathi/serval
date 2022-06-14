test :
	fennel -l ini.fnl tests.fnl

dev :
	nodemon --exec fennel -l ini.fnl tests.fnl

run :
	fennel -l ini.fnl main.fnl

run-dev :
	nodemon --exec fennel -l ini.fnl main.fnl

.PHONY: test dev run run-dev
