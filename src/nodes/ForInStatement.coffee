Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{oneOf} = require '../combinators'

TYPE = 'ForInStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  # TODO: disabled until https://code.google.com/p/esprima/issues/detail?id=449 is resolved
  #left: (oneOf [VariableDeclaration, LHSExpression]) depth
  left: (oneOf [LHSExpression]) depth
  right: Expression depth
  body: Statement depth
  each: false
