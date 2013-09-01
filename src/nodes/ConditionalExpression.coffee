Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ConditionalExpression extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @test = Expression depth
    @consequent = Expression depth
    @alternate = Expression depth

module.exports = construct ConditionalExpression
