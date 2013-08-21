Statement = require '../classes/Statement'
{listOf} = require '../combinators'

module.exports = ->
  type: 'BlockStatement'
  body: listOf Statement
