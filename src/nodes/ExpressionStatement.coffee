Expression = require '../classes/Expression'
Literal = require './Literal'

TYPE = 'ExpressionStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  expression: Expression depth
