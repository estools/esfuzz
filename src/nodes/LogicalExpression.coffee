Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

OPERATORS = ['||', '&&']
TYPE = 'LogicalExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  operator: oneOf OPERATORS
  left: Expression depth
  right: Expression depth
