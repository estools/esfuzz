BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{listOf} = require '../combinators'

TYPE = 'FunctionDeclaration'

module.exports = (depth) ->
  --depth
  type: TYPE
  id: Identifier depth
  params: (listOf [Identifier]) depth
  defaults: []
  rest: null
  body: BlockStatement depth
  generator: false
  expression: false
