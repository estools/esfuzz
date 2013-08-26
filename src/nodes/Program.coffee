Statement = require '../classes/Statement'
{listOfAtLeast} = require '../combinators'

TYPE = 'Program'
leaf = -> type: TYPE, body: []

module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  body: (listOfAtLeast 1, [Statement]) depth
