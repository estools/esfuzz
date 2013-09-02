Node = require '../node'
Expression = require '../classes/Expression'
Identifier = require './Identifier'
{construct, listOf} = require '../combinators'

class NewExpression extends Node
  type: @name
  arguments: []
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0
      ancestors = [this].concat ancestors
      @callee = Expression depth, ancestors
      @arguments = (listOf [Expression]) depth, ancestors
    else
      @callee = Identifier 0

module.exports = construct NewExpression
