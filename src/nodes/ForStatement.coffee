Node = require '../node'
Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{construct, oneOf, maybe} = require '../combinators'

class ForStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @init = (maybe oneOf [VariableDeclaration, Expression]) depth, ancestors
    @test = (maybe Expression) depth, ancestors
    @update = (maybe Expression) depth, ancestors
    @body = Statement depth, ancestors

module.exports = construct ForStatement
