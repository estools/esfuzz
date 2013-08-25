Expression = require '../classes/Expression'
Identifier = require './Identifier'
{oneOf} = require '../combinators'
{randomElement} = require '../helpers'

module.exports = ->
  type: 'AssignmentExpression'
  operator: randomElement ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']
  left: Identifier() # TODO: allow any valid LeftHandSideExpressions here
  right: oneOf Expression
