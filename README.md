# esfuzz

JS fuzzer for generative testing of parsers that implement the SpiderMonkey Reflect.parse API

esfuzz is currently a work in progress. The current status is on the wiki: https://github.com/michaelficarra/esfuzz/wiki/status

## Install

    npm install -g esfuzz

## Usage

### CLI

    $ esfuzz --help

      Usage: esfuzz OPT*

      -n, --iterations NUM  use at most NUM programs
      --acorn               enable marijnh/acorn parser; default: on
      --es6                 allow ECMAScript 6 features in generated programs
      --esprima             enable ariya/esprima parser; default: on
      --help                display this help message and exit
      --reflect             enable Reflect.parse parser; default: on if it exists
      --reflectjs           enable zaach/reflect.js parser
      --version             display the version number and exit

### Module Interface

#### `fuzz(parsers)` -> void

The exported `fuzz` function takes a list of objects that have a `parse` method
that obeys the SpiderMonkey Reflect.parse API. The fuzz function will generate
a random program, generate concrete syntax, run it through each parser, and
compare the outputs of each parser to the generated program. If any of the
parsers fail or create a program that does not match the generated program, an
error will be thrown.
