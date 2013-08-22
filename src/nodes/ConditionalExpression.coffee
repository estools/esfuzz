Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

module.exports = ->
  type: 'ConditionalExpression'
  test: oneOf Expression
  consequent: oneOf Expression
  alternate: oneOf Expression
