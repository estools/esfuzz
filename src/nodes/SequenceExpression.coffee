Expression = require '../classes/Expression'
{listOfAtLeast} = require '../combinators'

TYPE = 'SequenceExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  expressions: (listOfAtLeast 2, [Expression]) depth
