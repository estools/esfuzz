Expression = require '../classes/Expression'
{randomElement} = require '../random'
{construct} = require '../combinators'

OPERATORS = ['||', '&&']

class LogicalExpression
  type: @name
  constructor: (depth) ->
    --depth
    @operator = randomElement OPERATORS
    @left = Expression depth
    @right = Expression depth

module.exports = construct LogicalExpression
