Identifier = require './Identifier'
{construct, maybe} = require '../combinators'

# TODO: break can only exist in loops
class BreakStatement
  type: @name
  label: null
  constructor: (depth) ->
    --depth
    if depth > 0
      @label = (maybe Identifier) depth

module.exports = construct BreakStatement
