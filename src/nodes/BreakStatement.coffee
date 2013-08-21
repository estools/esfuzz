Identifier = require './Identifier'
{maybe, notReserved} = require '../combinators'

# TODO: break can only exist in loops
module.exports = ->
  type: 'BreakStatement'
  label: maybe -> notReserved Identifier
