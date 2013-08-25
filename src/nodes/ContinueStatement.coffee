Identifier = require './Identifier'
{maybe} = require '../combinators'

# TODO: continue can only exist in loops
module.exports = ->
  type: 'ContinueStatement'
  label: maybe Identifier
