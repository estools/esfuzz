nopt = require 'nopt'
{fuzz} = require './index'

knownOpts =
  esprima: Boolean
  acorn: Boolean
  reflectjs: Boolean
  reflect: Boolean
  es6: Boolean
  iterations: Number

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


process.on? 'SIGINT', ->
  process.stdout.write '  \n'
  process.exit 0


counter = 0
do recur = ->
  ++counter
  try
    fuzz parsers
  catch err
    {ast, js} = err
    console.error "\n\n#{err.stack}\n\n#{js}\n\n#{JSON.stringify ast}"
    process.exit 1
  process.stdout.write "\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{counter}"
  if counter < options.iterations
    setImmediate recur
  else
    process.stdout.write '\n'
  return
