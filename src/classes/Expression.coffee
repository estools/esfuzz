Literal = require './Literal'
{oneOf} = require '../combinators'

expressions = [Literal]
module.exports = (depth, args...) ->
  return Literal 0, args... unless depth > 0
  (oneOf expressions) arguments...

expressions.push require '../nodes/ArrayExpression'
expressions.push require '../nodes/AssignmentExpression'
expressions.push require '../nodes/BinaryExpression'
expressions.push require '../nodes/CallExpression'
expressions.push require '../nodes/ConditionalExpression'
expressions.push require '../nodes/FunctionExpression'
expressions.push require '../nodes/Identifier'
expressions.push require '../nodes/LogicalExpression'
expressions.push require '../nodes/MemberExpression'
expressions.push require '../nodes/NewExpression'
expressions.push require '../nodes/ObjectExpression'
expressions.push require '../nodes/SequenceExpression'
expressions.push require '../nodes/ThisExpression'
expressions.push require '../nodes/UnaryExpression'
expressions.push require '../nodes/UpdateExpression'
