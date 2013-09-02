Node = require '../node'
Expression = require '../classes/Expression'
Pattern = require '../classes/Pattern'
Identifier = require './Identifier'
{construct, maybe, listOfAtLeast} = require '../combinators'

class VariableDeclarator extends Node
  type: @name
  constructor: (depth) ->
    @id = Pattern depth
    @init = (maybe Expression) depth

class VariableDeclaration extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @declarations = (listOfAtLeast 1, [construct VariableDeclarator]) depth
    @kind = 'var' # TODO: let/const

module.exports = construct VariableDeclaration
