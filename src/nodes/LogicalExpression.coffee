Node = require '../node'
Expression = require '../classes/Expression'
{randomElement} = require '../random'
{construct} = require '../combinators'

OPERATORS = ['||', '&&']

class LogicalExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @operator = randomElement OPERATORS
    @left = Expression depth, ancestors
    @right = Expression depth, ancestors

module.exports = construct LogicalExpression
