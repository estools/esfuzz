Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{oneOf, maybe} = require '../combinators'

TYPE = 'ForStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  init: (oneOf [VariableDeclaration, Expression, -> null]) depth
  test: (maybe Expression) depth
  update: (maybe Expression) depth
  body: Statement depth
