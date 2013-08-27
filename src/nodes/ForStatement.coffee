Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
VariableDeclaration = require './VariableDeclaration'
{oneOf, maybe} = require '../combinators'

TYPE = 'ForStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  init: (maybe (oneOf [VariableDeclaration, Expression])) depth
  test: (maybe Expression) depth
  update: (maybe Expression) depth
  body: Statement depth
