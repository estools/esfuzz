Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ConditionalExpression
  type: @name
  constructor: (depth) ->
    --depth
    @test = Expression depth
    @consequent = Expression depth
    @alternate = Expression depth

module.exports = construct ConditionalExpression
