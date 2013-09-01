Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ExpressionStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @expression = Expression depth

module.exports = construct ExpressionStatement
