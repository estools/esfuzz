LHSExpression = require '../classes/LHSExpression'
{oneOf} = require '../combinators'
{randomBool} = require '../random'

TYPE = 'UpdateExpression'

module.exports = (depth) ->
  --depth
  lhs = LHSExpression depth
  # TODO: remove once https://github.com/marijnh/acorn/issues/54 is fixed
  while lhs.type in ['MemberExpression', 'CallExpression']
    lhs = LHSExpression depth
  type: TYPE
  operator: oneOf ['++', '--']
  argument: lhs
  prefix: randomBool()
