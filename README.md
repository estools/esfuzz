# esfuzz

JS fuzzer for generative testing of parsers that implement the SpiderMonkey Reflect.parse API

esfuzz is currently a work in progress. The current status is on the wiki: https://github.com/michaelficarra/esfuzz/wiki/status

## Install

    npm install -g esfuzz

## Usage

### CLI

    $ esfuzz --help


      Usage: esfuzz OPT*

      -n, --iterations NUM  use at most NUM programs; default: unlimited
      -d, --max-depth NUM   create ASTs with a height no greater than NUM; default: 8
      --acorn               enable marijnh/acorn parser; default: on
      --es6                 allow ECMAScript 6 features in generated programs
      --esprima             enable ariya/esprima parser; default: on
      --help                display this help message and exit
      --reflect             enable Reflect.parse parser; default: on if it exists
      --reflectjs           enable zaach/reflect.js parser
      --uglifyjs            enable limited support for mishoo/UglifyJS2
      --version             display the version number and exit
      --zeparser            enable limited support for qfox/ZeParser

### Module Interface

#### `generate(options)` -> `SpiderMonkey_AST`

Generate a random SpiderMonkey AST that represents a valid ECMAScript program.
Available options:

  * `maxDepth`: create ASTs with a height no greater than this value

#### `fuzz(programAST, parsers)` -> `void`

The exported `fuzz` function takes a SpiderMonkey AST and a list of objects
that have a `parse` method that obeys the SpiderMonkey Reflect.parse API. This
function will generate concrete syntax and run it through each parser. If any
of the parsers fail to parse the program, an error will be thrown.

#### `fuzzAndRoundtrip(programAST, parsers)` -> `void`

Identical to `fuzz`, except additionally compares the outputs of each parser to
the generated program. If any of the parsers fail to parse the program or fail
to generate an AST equivalent to the given one, an error will be thrown.
