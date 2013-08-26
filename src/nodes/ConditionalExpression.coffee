Expression = require '../classes/Expression'

TYPE = 'ConditionalExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  test: Expression depth
  consequent: Expression depth
  alternate: Expression depth
