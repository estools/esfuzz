Node = require '../node'
Expression = require '../classes/Expression'
{construct, listOfAtLeast} = require '../combinators'

class SequenceExpression extends Node
  type: @name
  constructor: (depth) ->
    --depth
    ancestors = [this].concat ancestors
    @expressions = (listOfAtLeast 2, [Expression]) depth, ancestors

module.exports = construct SequenceExpression
