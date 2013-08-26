Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

OPERATORS = ['-', '+', '!', '~', 'typeof', 'void', 'delete']
TYPE = 'UnaryExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  operator: oneOf OPERATORS
  prefix: true
  argument: Expression depth
