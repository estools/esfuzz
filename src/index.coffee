escodegen = require 'escodegen'

{randomInt, randomElement} = require './helpers'
{listOf, listOfAtLeast, oneOf, maybe, notReserved} = require './combinators'

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
  #-> type: 'Literal', value: 0, raw: '0.'
  #-> type: 'Literal', value: 0, raw: '.0'
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



class RoundtripFailureError extends Error
  name: 'RoundtripFailureError'
  constructor: (@message) ->
    Error.call this
    Error.captureStackTrace? this, RoundtripFailureError

render = (program) -> escodegen.generate program, format: escodegen.FORMAT_MINIFY

exports.fuzz = (parsers) ->
  programAST = Program()
  program = escodegen.generate programAST, verbatim: 'raw', format: escodegen.FORMAT_MINIFY
  try
    roundTrippedPrograms = (render parser.parse program for parser in parsers)
  catch err
    err.ast = programAST
    err.js = program
    throw err
  targetProgram = render programAST
  for roundTrippedProgram in roundTrippedPrograms when roundTrippedProgram isnt targetProgram
    err = new RoundtripFailureError
    err.ast = programAST
    err.js = program
    throw err
  return
