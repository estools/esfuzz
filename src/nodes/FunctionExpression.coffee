BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{construct, listOf, maybe} = require '../combinators'

class FunctionExpression
  type: @name
  defaults: []
  rest: null
  generator: false
  expression: false
  constructor: (depth) ->
    --depth
    @id = (maybe Identifier) depth
    @params = (listOf [Identifier]) depth
    @body = BlockStatement depth

module.exports = construct FunctionExpression
