LHSExpression = require '../classes/LHSExpression'
{oneOf} = require '../combinators'
{randomBool} = require '../helpers'

TYPE = 'UpdateExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  operator: oneOf ['++', '--']
  argument: LHSExpression depth
  prefix: randomBool()
