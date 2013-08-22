Expression = require '../classes/Expression'
{oneOf, listOf} = require '../combinators'

module.exports = ->
  type: 'NewExpression'
  callee: oneOf Expression
  arguments: listOf Expression
