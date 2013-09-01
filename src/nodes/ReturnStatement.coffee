Node = require '../node'
Expression = require '../classes/Expression'
{construct, maybe} = require '../combinators'

# TODO: return can only exist within functions
class ReturnStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @argument = (maybe Expression) depth

module.exports = construct ReturnStatement
