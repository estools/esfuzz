Node = require '../node'
Statement = require '../classes/Statement'
Identifier = require './Identifier'
{construct} = require '../combinators'

labelNames = (ancestors) ->
  accum = []
  for ancestor in ancestors
    if ancestor.type is 'FunctionDeclaration'
      break
    else if ancestor.type is 'LabeledStatement'
      accum.push ancestor.label.name
  accum

class LabeledStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestorLabelNames = labelNames ancestors
    ancestors = [this].concat ancestors
    id = null
    until id? and id.name not in ancestorLabelNames
      id = Identifier depth, ancestors
    @label = id
    @body = Statement depth, ancestors

module.exports = construct LabeledStatement
