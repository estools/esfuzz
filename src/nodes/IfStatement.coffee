Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{oneOf, maybe} = require '../combinators'

module.exports = ->
  type: 'IfStatement'
  test: oneOf Expression
  consequent: oneOf Statement
  alternate: maybe -> oneOf Statement
