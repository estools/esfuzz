Node = require '../node'
Pattern = require '../classes/Pattern'
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
    @params = (listOf [Pattern]) depth
    @body = BlockStatement depth

module.exports = construct FunctionDeclaration
