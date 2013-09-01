Expression = require '../classes/Expression'
{construct} = require '../combinators'

class ThrowStatement
  type: @name
  constructor: (depth) ->
    --depth
    @argument = Expression depth

module.exports = construct ThrowStatement
