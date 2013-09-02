Node = require '../node'
Expression = require '../classes/Expression'
{construct} = require '../combinators'
{randomElement} = require '../random'

OPERATORS = ['-', '+', '!', '~', 'typeof', 'void', 'delete']

class UnaryExpression extends Node
  type: @name
  prefix: true
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @operator = randomElement OPERATORS
    @argument = Expression depth, ancestors

module.exports = construct UnaryExpression
