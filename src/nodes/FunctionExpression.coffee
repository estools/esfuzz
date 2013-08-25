BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{listOf, maybe} = require '../combinators'

module.exports = ->
  type: 'FunctionExpression'
  id: maybe Identifier
  params: listOf [Identifier]
  defaults: []
  rest: null
  body: BlockStatement()
  generator: false
  expression: false
