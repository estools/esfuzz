Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class WithStatement
  type: @name
  constructor: (depth) ->
    --depth
    @object = Expression depth
    @body = Statement depth

module.exports = construct WithStatement
