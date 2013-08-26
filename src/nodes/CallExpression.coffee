Expression = require '../classes/Expression'
Identifier = require './Identifier'
{listOf} = require '../combinators'

TYPE = 'CallExpression'
leaf = ->
  type: TYPE
  callee: Identifier 0
  arguments: []

module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  callee: Expression depth
  arguments: (listOf [Expression]) depth
