Node = require '../node'
Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct, maybe} = require '../combinators'

class IfStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @test = Expression depth, ancestors
    @consequent = Statement depth, ancestors
    @alternate = (maybe Statement) depth, ancestors

module.exports = construct IfStatement
