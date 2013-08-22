Expression = require '../classes/Expression'
{oneOf, maybe, listOf} = require '../combinators'

module.exports = ->
  type: 'ArrayExpression'
  elements: listOf [-> null, Expression...]
