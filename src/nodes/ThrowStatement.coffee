Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ThrowStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @argument = Expression depth

module.exports = construct ThrowStatement
