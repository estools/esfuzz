Expression = require '../classes/Expression'
Identifier = require './Identifier'
{oneOf, notReserved} = require '../combinators'
{randomElement} = require '../helpers'

module.exports = ->
  type: 'AssignmentExpression'
  operator: randomElement ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']
  left: notReserved Identifier # TODO: allow any valid LeftHandSideExpressions here
  right: oneOf Expression
