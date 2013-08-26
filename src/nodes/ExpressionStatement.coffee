Expression = require '../classes/Expression'

TYPE = 'ExpressionStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  expression: Expression depth
