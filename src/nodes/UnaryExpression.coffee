Expression = require '../classes/Expression'
{construct} = require '../combinators'
{randomElement} = require '../random'

OPERATORS = ['-', '+', '!', '~', 'typeof', 'void', 'delete']

class UnaryExpression
  type: @name
  prefix: true
  constructor: (depth) ->
    --depth
    @operator = randomElement OPERATORS
    @argument = Expression depth

module.exports = construct UnaryExpression
