Node = require '../node'
Statement = require '../classes/Statement'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'
{randomElement} = require '../random'

FUNCTIONS = ['FunctionDeclaration', 'FunctionExpression']
ITERATION_STATEMENTS = ['ForStatement', 'ForInStatement', 'DoWhileStatement', 'WhileStatement']

continuable = (ancestors) ->
  for ancestor in ancestors
    return false if ancestor.type in FUNCTIONS
    return true if ancestor.type in ITERATION_STATEMENTS
  false

labels = (ancestors) ->
  accum = []
  for ancestor, i in ancestors
    break if ancestor.type in FUNCTIONS
    accum.push ancestor.label if ancestor.type is 'LabeledStatement' and i > 0 and ancestors[i-1].type in ITERATION_STATEMENTS
  accum

class ContinueStatement extends Node
  type: @name
  label: null
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0 and continuable ancestors
      @label = (maybe -> randomElement labels ancestors) depth
    else
      return Statement 0

module.exports = construct ContinueStatement
