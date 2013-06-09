REPORTER = dot

build:
	@coffee --compile --output lib/ src/

build-watch:
	@coffee -o lib -cw src

test:
	./node_modules/.bin/mocha \
			--require ./test/common \
			--reporter $(REPORTER) \
			--growl \
			./tests/dojodatabase.js
