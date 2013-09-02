Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ExpressionStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    @expression = Expression depth, [this].concat ancestors

module.exports = construct ExpressionStatement
