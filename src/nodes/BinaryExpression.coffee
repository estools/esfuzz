Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

OPERATORS = ['==', '!=', '===', '!==', '<', '<=', '>', '>=', '<<', '>>', '>>>', '+', '-', '*', '/', '%', '|', '^', 'in', 'instanceof']
TYPE = 'BinaryExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  operator: oneOf OPERATORS
  left: Expression depth
  right: Expression depth
