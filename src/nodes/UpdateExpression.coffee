Expression = require '../classes/Expression'
{oneOf} = require '../combinators'
{randomBool, randomElement} = require '../helpers'

module.exports = ->
  type: 'UpdateExpression'
  operator: randomElement ['++', '--']
  argument: oneOf Expression # TODO: only allow LHSExpressions
  prefix: randomBool()
