Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ExpressionStatement
  type: @name
  constructor: (depth) ->
    --depth
    @expression = Expression depth

module.exports = construct ExpressionStatement
