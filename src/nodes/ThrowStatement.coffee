Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ThrowStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @argument = Expression depth, ancestors

module.exports = construct ThrowStatement
