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
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @id = Identifier depth, ancestors
    @params = (listOf [Pattern]) depth, ancestors
    @body = BlockStatement depth, ancestors

module.exports = construct FunctionDeclaration
