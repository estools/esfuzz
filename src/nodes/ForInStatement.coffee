Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{construct, oneOf} = require '../combinators'

class ForInStatement
  type: @name
  each: false
  constructor: (depth) ->
    --depth
    # TODO: disabled until https://code.google.com/p/esprima/issues/detail?id=449 is resolved
    #@left = (oneOf [VariableDeclaration, LHSExpression]) depth
    @left = LHSExpression depth
    @right = Expression depth
    @body = Statement depth

module.exports = construct ForInStatement
