Identifier = require './Identifier'
{maybe, notReserved} = require '../combinators'

# TODO: continue can only exist in loops
module.exports = ->
  type: 'ContinueStatement'
  label: maybe -> notReserved Identifier
