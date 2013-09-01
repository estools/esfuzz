Statement = require '../classes/Statement'
{construct, listOf} = require '../combinators'

class BlockStatement
  type: @name
  body: []
  constructor: (depth) ->
    --depth
    if depth > 0
      @body = (listOf [Statement]) depth

module.exports = construct BlockStatement
