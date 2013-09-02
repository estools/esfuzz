Node = require '../node'
Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
{construct} = require '../combinators'

class DoWhileStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @body = Statement depth, ancestors
    @test = Expression depth, ancestors

module.exports = construct DoWhileStatement
