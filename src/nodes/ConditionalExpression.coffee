Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ConditionalExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @test = Expression depth, ancestors
    @consequent = Expression depth, ancestors
    @alternate = Expression depth, ancestors

module.exports = construct ConditionalExpression
