Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

module.exports = ->
  type: 'ExpressionStatement'
  expression: oneOf Expression
