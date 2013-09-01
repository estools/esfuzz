Expression = require '../classes/Expression'
{construct, maybe, listOf} = require '../combinators'

class ArrayExpression
  type: @name
  constructor: (depth) ->
    --depth
    @elements = (listOf [maybe Expression]) depth

module.exports = construct ArrayExpression
