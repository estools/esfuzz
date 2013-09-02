Node = require '../node'
Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct} = require '../combinators'

class WithStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @object = Expression depth, ancestors
    @body = Statement depth, ancestors

module.exports = construct WithStatement
