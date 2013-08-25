Expression = require '../classes/Expression'
{oneOf} = require '../combinators'
{randomElement} = require '../helpers'

module.exports = ->
  type: 'BinaryExpression'
  operator: randomElement ['==', '!=', '===', '!==', '<', '<=', '>', '>=', '<<', '>>', '>>>', '+', '-', '*', '/', '%', '|', '^', 'in', 'instanceof']
  left: oneOf Expression
  right: oneOf Expression
