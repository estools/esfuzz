Node = require '../node'
Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
{construct} = require '../combinators'

class WhileStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @test = Expression depth
    @body = Statement depth

module.exports = construct WhileStatement
