Node = require '../node'
Statement = require '../classes/Statement'
{construct, listOf} = require '../combinators'

class BlockStatement extends Node
  type: @name
  body: []
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0
      ancestors = [this].concat ancestors
      @body = (listOf [Statement]) depth, ancestors

module.exports = construct BlockStatement
