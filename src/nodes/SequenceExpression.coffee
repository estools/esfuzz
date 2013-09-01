Expression = require '../classes/Expression'
{construct, listOfAtLeast} = require '../combinators'

class SequenceExpression
  type: @name
  constructor: (depth) ->
    --depth
    @expressions = (listOfAtLeast 2, [Expression]) depth

module.exports = construct SequenceExpression
