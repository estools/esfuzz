BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{listOf} = require '../combinators'

module.exports = ->
  type: 'FunctionDeclaration'
  id: Identifier()
  params: listOf [Identifier]
  defaults: []
  rest: null
  body: BlockStatement()
  generator: false
  expression: false
