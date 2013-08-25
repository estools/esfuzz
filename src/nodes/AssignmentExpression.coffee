Expression = require '../classes/Expression'
LHSExpression = require '../classes/LHSExpression'
{oneOf} = require '../combinators'
{randomElement} = require '../helpers'

module.exports = ->
  type: 'AssignmentExpression'
  operator: randomElement ['=', '+=', '-=', '*=', '/=', '%=', '<<=', '>>=', '>>>=', '|=', '^=', '&=']
  left: LHSExpression()
  right: oneOf Expression
