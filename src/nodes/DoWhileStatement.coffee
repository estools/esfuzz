Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
{construct} = require '../combinators'

class DoWhileStatement
  type: @name
  constructor: (depth) ->
    --depth
    @body = Statement depth
    @test = Expression depth

module.exports = construct DoWhileStatement
