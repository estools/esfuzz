path = require 'path'

nopt = require 'nopt'
{fuzz} = require './index'

knownOpts =
  acorn: Boolean
  es6: Boolean
  esprima: Boolean
  help: Boolean
  iterations: Number
  reflect: Boolean
  reflectjs: Boolean
  version: Boolean

optAliases =
  n: '--iterations'

options = nopt knownOpts, optAliases, process.argv, 2
# defaults
options.esprima ?= on
options.acorn ?= on
options.reflect ?= Reflect? and 'function' is typeof Reflect.parse
options.iterations ?= 1/0

parsers = []
if options.esprima then try parsers.push require 'esprima'
if options.acorn then try parsers.push require 'acorn'
if options.reflectjs then try parsers.push require 'reflect'
if options.reflect then try parsers.push Reflect


if options.help
  $0 = if process.argv[0] is 'node' then process.argv[1] else process.argv[0]
  $0 = path.basename $0
  console.log "
  Usage: #{$0} OPT*

  -n, --iterations NUM  use at most NUM programs
  --acorn               enable marijnh/acorn parser; default: on
  --es6                 allow ECMAScript 6 features in generated programs
  --esprima             enable ariya/esprima parser; default: on
  --help                display this help message and exit
  --reflect             enable Reflect.parse parser; default: on if it exists
  --reflectjs           enable zaach/reflect.js parser
  --version             display the version number and exit
"
  process.exit 0

if options.version
  console.log (require '../package.json').version
  process.exit 0


process.on 'SIGINT', ->
  process.stdout.write '  \n'
  process.exit 0


counter = 0
do recur = ->
  if counter < options.iterations
    process.stdout.write "\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{++counter}"
    try
      fuzz parsers
    catch err
      {stack, ast, js, name, message} = err
      console.error "\b\b\b\b\b\b\b\b\b\b\b\b\b#{name}: #{message}\n\n#{stack}\n\n#{js}\n\n#{JSON.stringify ast}"
      process.exit 1
    setImmediate recur
  else
    process.stdout.write '\n'
  return
