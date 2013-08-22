Expression = require '../classes/Expression'
{oneOf, listOf} = require '../combinators'

module.exports = ->
  type: 'CallExpression'
  callee: oneOf Expression
  arguments: listOf Expression
