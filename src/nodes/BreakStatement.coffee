Identifier = require './Identifier'
{maybe} = require '../combinators'

TYPE = 'BreakStatement'
leaf = -> type: TYPE, label: null

# TODO: break can only exist in loops
module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  label: (maybe Identifier) depth
