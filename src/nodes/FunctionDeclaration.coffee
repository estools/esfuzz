BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{listOf, notReserved} = require '../combinators'

module.exports = ->
  type: 'FunctionDeclaration'
  id: notReserved Identifier
  params: listOf [(-> notReserved Identifier)], 10
  defaults: []
  rest: null
  body: BlockStatement()
  generator: false
  expression: false
