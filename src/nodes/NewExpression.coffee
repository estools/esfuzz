Expression = require '../classes/Expression'
Identifier = require './Identifier'
{construct, listOf} = require '../combinators'

class NewExpression
  type: @name
  arguments: []
  constructor: (depth) ->
    --depth
    if depth > 0
      @callee = Expression depth
      @arguments = (listOf [Expression]) depth
    else
      @callee = Identifier 0

module.exports = construct NewExpression
