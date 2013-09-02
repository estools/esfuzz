Node = require '../node'
Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{construct, oneOf} = require '../combinators'

class ForInStatement extends Node
  type: @name
  each: false
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    # TODO: disabled until https://code.google.com/p/esprima/issues/detail?id=449 is resolved
    #@left = (oneOf [VariableDeclaration, LHSExpression]) depth
    @left = LHSExpression depth, ancestors
    @right = Expression depth, ancestors
    @body = Statement depth, ancestors

module.exports = construct ForInStatement
