{notReserved} = require '../combinators'

module.exports = expressions = []

expressions.push require '../nodes/FunctionExpression'
expressions.push -> notReserved require '../nodes/Identifier'
expressions.push require '../nodes/Literal'
expressions.push require '../nodes/ThisExpression'
