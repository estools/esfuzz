Node = require '../node'
Statement = require '../classes/Statement'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'
{randomElement} = require '../random'

FUNCTIONS = ['FunctionDeclaration', 'FunctionExpression']
ITERATION_STATEMENTS = ['ForStatement', 'ForInStatement', 'DoWhileStatement', 'WhileStatement']

breakable = (ancestors) ->
  for ancestor in ancestors
    return false if ancestor.type in FUNCTIONS
    return true if ancestor.type in ITERATION_STATEMENTS or ancestor.type is 'SwitchStatement'
  false

labels = (ancestors) ->
  accum = []
  for ancestor in ancestors
    break if ancestor.type in FUNCTIONS
    accum.push ancestor.label if ancestor.type is 'LabeledStatement'
  accum

class BreakStatement extends Node
  type: @name
  label: null
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0 and breakable ancestors
      @label = (maybe -> randomElement labels ancestors) depth
    else
      return Statement 0

module.exports = construct BreakStatement
