Expression = require '../classes/Expression'
{oneOf} = require '../combinators'
{randomElement} = require '../helpers'

module.exports = ->
  type: 'UnaryExpression'
  operator: randomElement ['-',  '+',  '!',  '~',  'typeof',  'void',  'delete']
  prefix: true
  argument: oneOf Expression
