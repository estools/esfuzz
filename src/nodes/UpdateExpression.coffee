LHSExpression = require '../classes/LHSExpression'
{oneOf} = require '../combinators'
{randomBool, randomElement} = require '../helpers'

module.exports = ->
  type: 'UpdateExpression'
  operator: randomElement ['++', '--']
  argument: LHSExpression()
  prefix: randomBool()
