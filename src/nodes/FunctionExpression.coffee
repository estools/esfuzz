BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{listOf, maybe} = require '../combinators'

TYPE = 'FunctionExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  id: (maybe Identifier) depth
  params: (listOf [Identifier]) depth
  defaults: []
  rest: null
  body: BlockStatement depth
  generator: false
  expression: false
