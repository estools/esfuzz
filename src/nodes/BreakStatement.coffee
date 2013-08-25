Identifier = require './Identifier'
{maybe} = require '../combinators'

# TODO: break can only exist in loops
module.exports = ->
  type: 'BreakStatement'
  label: maybe Identifier
