Node = require '../node'
Expression = require '../classes/Expression'
{construct, maybe, listOf} = require '../combinators'

class ArrayExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @elements = (listOf [maybe Expression]) depth, ancestors

module.exports = construct ArrayExpression
