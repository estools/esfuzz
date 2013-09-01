Node = require '../node'
Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct, maybe} = require '../combinators'

class IfStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @test = Expression depth
    @consequent = Statement depth
    @alternate = (maybe Statement) depth

module.exports = construct IfStatement
