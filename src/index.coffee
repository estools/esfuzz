escodegen = require 'escodegen'

esprima = require 'esprima'
acorn = require 'acorn'
#reflect = require 'reflect'

RESERVED = [
  # keywords
  'break', 'case', 'catch', 'class', 'const', 'continue', 'debugger',
  'default', 'delete', 'do', 'else', 'enum', 'export', 'extends', 'finally',
  'for', 'function', 'if', 'import', 'in', 'instanceof', 'new', 'return',
  'super', 'switch', 'this', 'throw', 'try', 'typeof', 'var', 'void', 'while',
  'with',
  # future reserved words
  'implements', 'let', 'private', 'public', 'yield', 'interface', 'package',
  'protected', 'static', 'class', 'enum', 'extends', 'super', 'const',
  'export', 'import',
  # null, booleans
  'null', 'true', 'false'
]

class RoundtripFailureError extends Error


## helpers

global.setImmediate ?= (fn) -> setTimeout fn, 0
randomInt = (max) -> Math.floor(Math.random() * (max + 1))
randomElement = (list) -> list[randomInt list.length - 1]
render = (program) -> escodegen.generate program, format: escodegen.FORMAT_MINIFY
take = (n, list) -> e for e, i in list when i < n


## combinators

listOf = (possibleGenerators) ->
  while Math.random() < 0.4
    oneOf possibleGenerators

listOfAtLeast = (possibleGenerators, min) ->
  (oneOf possibleGenerators for _ in [1..min]).concat listOf possibleGenerators

oneOf = (possibleGenerators) ->
  (randomElement possibleGenerators)()

maybe = (generator) ->
  if randomElement [true, false] then generator() else null

notReserved = (generator) ->
  id = generator()
  id.name = if id.name in RESERVED then "#{id.name}_" else id.name
  id


## node generators

Program = ->
  type: 'Program'
  body: listOfAtLeast statements, 1

BlockStatement = ->
  type: 'BlockStatement'
  body: listOf statements

ExpressionStatement = ->
  type: 'ExpressionStatement'
  expression: oneOf expressions

EmptyStatement = -> type: 'EmptyStatement'

DebuggerStatement = -> type: 'DebuggerStatement'

IfStatement = ->
  type: 'IfStatement'
  test: oneOf expressions
  consequent: oneOf statements
  alternate: maybe -> oneOf statements

# TODO: these need to be unique per program
#LabeledStatement = ->
#  type: 'LabeledStatement'
#  label: label
#  body: oneOf statements

WithStatement = ->
  type: 'WithStatement'
  object: oneOf expressions
  body: oneOf statements

SwitchStatement = ->
  type: 'SwitchStatement'
  discriminant: oneOf expressions
  cases: (listOf [SwitchCase]).concat oneOf [SwitchCaseDefault, -> []]
  lexical: false

SwitchCase = ->
  type: 'SwitchCase'
  test: oneOf expressions
  consequent: [oneOf statements].concat listOf statements

# TODO: SwitchCaseFallthrough

SwitchCaseDefault = ->
  type: 'SwitchCase'
  test: null
  consequent: [oneOf statements].concat listOf statements

# TODO: continue and break can only exist in loops; return can only exist within functions
#ContinueStatement = ->
#  type: 'ContinueStatement'
#  label: notReserved -> maybe Identifier
#
#BreakStatement = ->
#  type: 'BreakStatement'
#  label: notReserved -> maybe Identifier
#
#ReturnStatement = ->
#  type: 'ReturnStatement'
#  argument: maybe -> oneOf expressions

FunctionDeclaration = ->
    type: 'FunctionDeclaration'
    id: notReserved Identifier
    params: listOf [(-> notReserved Identifier)], 10
    defaults: []
    rest: null
    body: BlockStatement()
    generator: false
    expression: false

FunctionExpression = ->
    type: 'FunctionExpression'
    id: maybe -> notReserved Identifier
    params: listOf [(-> notReserved Identifier)], 10
    defaults: []
    rest: null
    body: BlockStatement()
    generator: false
    expression: false

# TODO: second code path that generates full range of characters allowed in identifier{Start,Part}
Identifier = ->
  identifierStart = identifierPart = -> String.fromCharCode 97 + randomInt 25
  type: 'Identifier'
  name: [identifierStart(), (identifierPart() while Math.random() < 0.8)...].join ''

Number_ = -> oneOf [
  -> type: 'Literal', value: 0
  -> type: 'Literal', value: 0, raw: '0.'
  -> type: 'Literal', value: 0, raw: '.0'
  ->
    int = randomInt (Math.pow 2, 53) - 1
    type: 'Literal', value: int, raw: switch randomInt 10
      when 0 then "#{randomElement ['0', '00', '000', '0000']}#{int.toString 8}"
      when 1 then "0#{randomElement ['x', 'X']}#{int.toString 16}"
      else int.toString()
  # TODO: scientific notation
]

String_ = ->
  # TODO: this should be 0-65535, but only esprima supports most of these strings
  chars = (String.fromCharCode 32 + randomInt 94 while Math.random() < 0.95)
  type: 'Literal', value: chars.join ''


terminalStatements = [ExpressionStatement, EmptyStatement, DebuggerStatement]
toplevelStatements = [terminalStatements..., IfStatement, BlockStatement, WithStatement, SwitchStatement, FunctionDeclaration]
statements = [toplevelStatements...]
expressions = [Number_, String_, (-> notReserved Identifier), FunctionExpression]

process.on? 'SIGINT', ->
  process.stdout.write '  \n'
  process.exit 0


#console.log render Program()
#process.exit 0


parsers = [esprima, acorn]
# Reflect.js: don't enable this unless you want lots of failures
#parsers.push reflect
if Reflect? and 'function' is typeof Reflect.parse
  parsers.push Reflect

exports.fuzz = fuzz = (desiredCount, cb) ->
  if arguments.length < 2
    cb = desiredCount
    desiredCount = 1/0
  counter = 0
  do recur = ->
    ++counter
    programAST = Program()
    program = escodegen.generate programAST, verbatim: 'raw', format: escodegen.FORMAT_MINIFY
    try
      roundTrippedPrograms = (render parser.parse program for parser in parsers)
    catch err
      err.ast = programAST
      err.js = program
      cb err
      return
    if process.stdout
      process.stdout.write "\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{counter}"
    else if 0 is counter % 100
      console.clear?()
      console.log counter
    targetProgram = render programAST
    for roundTrippedProgram in roundTrippedPrograms when roundTrippedProgram isnt targetProgram
      err = new RoundtripFailureError
      err.ast = programAST
      err.js = program
      cb err
      return
    if counter < desiredCount then setImmediate recur else setImmediate cb
    return
  return

fuzz 1e4, (err) ->
  if err?
    {ast, js} = err
    console.error "\n#{err.stack}\n#{js}\n\n#{JSON.stringify ast}"
    process.exit 1
  else
    process.stdout?.write '\n'
