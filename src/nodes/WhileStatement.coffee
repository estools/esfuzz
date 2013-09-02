Node = require '../node'
Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
{construct} = require '../combinators'

class WhileStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @test = Expression depth, ancestors
    @body = Statement depth, ancestors

module.exports = construct WhileStatement
