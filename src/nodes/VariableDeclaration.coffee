Node = require '../node'
Expression = require '../classes/Expression'
Pattern = require '../classes/Pattern'
Identifier = require './Identifier'
{construct, maybe, listOfAtLeast} = require '../combinators'

class VariableDeclarator extends Node
  type: @name
  constructor: (depth, ancestors) ->
    ancestors = [this].concat ancestors
    @id = Pattern depth, ancestors
    @init = (maybe Expression) depth, ancestors

class VariableDeclaration extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    @declarations = (listOfAtLeast 1, [construct VariableDeclarator]) depth, ancestors
    @kind = 'var' # TODO: let/const

module.exports = construct VariableDeclaration
