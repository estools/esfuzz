Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
Identifier = require './Identifier'
{oneOf} = require '../combinators'

OPERATORS = ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']
TYPE = 'AssignmentExpression'
leaf = ->
  type: TYPE
  operator: oneOf OPERATORS
  left: Identifier 0
  right: Expression 0

module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  operator: oneOf OPERATORS
  left: LHSExpression depth
  right: Expression depth
