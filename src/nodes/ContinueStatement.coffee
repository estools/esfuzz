Node = require '../node'
Statement = require '../classes/Statement'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'
{randomElement} = require '../random'

continuable = (ancestors) ->
  for ancestor in ancestors
    return false if ancestor.type in ['FunctionDeclaration', 'FunctionExpression']
    return true if ancestor.type in ['ForStatement', 'ForInStatement', 'DoWhileStatement', 'WhileStatement']
  false

labels = (ancestors) ->
  accum = []
  for ancestor in ancestors
    break if ancestor.type in ['FunctionDeclaration', 'FunctionExpression']
    accum.push ancestor.label if ancestor.type is 'LabeledStatement'
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
