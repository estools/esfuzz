Node = require '../node'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'

# TODO: continue can only exist in loops
class ContinueStatement extends Node
  type: @name
  label: null
  constructor: (depth) ->
    --depth
    if depth > 0
      @label = (maybe Identifier) depth

module.exports = construct ContinueStatement
