Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Identifier = require './Identifier'
{construct} = require '../combinators'
{randomElement} = require '../random'

OPERATORS = ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']

class AssignmentExpression
  type: @name
  constructor: (depth) ->
    --depth
    @operator = randomElement OPERATORS
    if depth > 0
      @left = LHSExpression depth
      @right = Expression depth
    else
      @left = Identifier 0
      @right = Expression 0

module.exports = construct AssignmentExpression
