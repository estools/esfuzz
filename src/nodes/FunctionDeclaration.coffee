Node = require '../node'
BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{construct, listOf} = require '../combinators'

class FunctionDeclaration extends Node
  type: @name
  defaults: []
  rest: null
  generator: false
  expression: false
  constructor: (depth) ->
    --depth
    @id = Identifier depth
    @params = (listOf [Identifier]) depth
    @body = BlockStatement depth

module.exports = construct FunctionDeclaration
