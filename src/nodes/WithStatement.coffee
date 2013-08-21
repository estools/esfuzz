Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{oneOf} = require '../combinators'

module.exports = ->
  type: 'WithStatement'
  object: oneOf Expression
  body: oneOf Statement
