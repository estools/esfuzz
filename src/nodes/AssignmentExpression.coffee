Node = require '../node'
Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Identifier = require './Identifier'
{construct} = require '../combinators'
{randomElement} = require '../random'

OPERATORS = ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']

class AssignmentExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    @operator = randomElement OPERATORS
    if depth > 0
      ancestors = [this].concat ancestors
      @left = LHSExpression depth, ancestors
      @right = Expression depth, ancestors
    else
      @left = Identifier 0
      @right = Expression 0

module.exports = construct AssignmentExpression
