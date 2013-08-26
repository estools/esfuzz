Statement = require '../classes/Statement'
{listOf} = require '../combinators'

TYPE = 'BlockStatement'
leaf = -> type: TYPE, body: []

module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  body: (listOf [Statement]) depth
