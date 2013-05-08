REPORTER = dot

build:
	@coffee --compile --output lib/ src/

test:
	./node_modules/.bin/mocha \
			--require ./test/common \
			--reporter $(REPORTER) \
			--growl \
			./tests/dojodatabase.js
