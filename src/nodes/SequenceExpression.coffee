Node = require '../node'
Expression = require '../classes/Expression'
{construct, listOfAtLeast} = require '../combinators'

class SequenceExpression extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @expressions = (listOfAtLeast 2, [Expression]) depth

module.exports = construct SequenceExpression
