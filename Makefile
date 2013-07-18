default: build

BINDIR = bin
SRCDIR = src
LIBDIR = lib
TESTDIR = test
DISTDIR = dist

SRC = $(wildcard $(SRCDIR)/*.coffee | sort)
LIB = $(SRC:$(SRCDIR)/%.coffee=$(LIBDIR)/%.js)
TEST = $(wildcard $(TESTDIR)/*.coffee | sort)

COFFEE=node_modules/.bin/coffee --js
MOCHA=node_modules/.bin/mocha --compilers coffee:coffee-script-redux/register -r coffee-script-redux/register -r test-setup.coffee -u tdd -R dot
CJSIFY=node_modules/.bin/cjsify --minify

all: build test
build: $(LIB)
bundle: $(DISTDIR)/bundle.js

$(LIBDIR)/%.js: $(SRCDIR)/%.coffee
	@mkdir -p "$(@D)"
	$(COFFEE) <"$<" >"$@"

$(DISTDIR)/bundle.js: $(LIB)
	@mkdir -p "$(@D)"
	$(CJSIFY) -x ProjectName $(shell node -pe 'require("./package.json").main') >"$@"

.PHONY: phony-dep release test loc clean
phony-dep:

VERSION = $(shell node -pe 'require("./package.json").version')
release-patch: NEXT_VERSION = $(shell node -pe 'require("semver").inc("$(VERSION)", "patch")')
release-minor: NEXT_VERSION = $(shell node -pe 'require("semver").inc("$(VERSION)", "minor")')
release-major: NEXT_VERSION = $(shell node -pe 'require("semver").inc("$(VERSION)", "major")')
release-patch: release
release-minor: release
release-major: release

release: build test
	@printf "Current version is $(VERSION). This will publish version $(NEXT_VERSION). Press [enter] to continue." >&2
	@read
	node -e '\
		var j = require("./package.json");\
		j.version = "$(NEXT_VERSION)";\
		var s = JSON.stringify(j, null, 2) + "\n";\
		require("fs").writeFileSync("./package.json", s);'
	git commit package.json -m 'Version $(NEXT_VERSION)'
	git tag -a "v$(NEXT_VERSION)" -m "Version $(NEXT_VERSION)"
	git push --tags origin HEAD:master
	npm publish

test:
	$(MOCHA) $(TEST)
$(TESTDIR)/%.coffee: phony-dep
	$(MOCHA) "$@"

loc:
	@wc -l "$(SRCDIR)"/*

clean:
	@rm -rf "$(LIBDIR)" "$(DISTDIR)"
