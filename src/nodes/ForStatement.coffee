Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{construct, oneOf, maybe} = require '../combinators'

class ForStatement
  type: @name
  constructor: (depth) ->
    --depth
    @init = (maybe oneOf [VariableDeclaration, Expression]) depth
    @test = (maybe Expression) depth
    @update = (maybe Expression) depth
    @body = Statement depth

module.exports = construct ForStatement
