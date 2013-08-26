Expression = require '../classes/Expression'
{listOf} = require '../combinators'

TYPE = 'ArrayExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  elements: (listOf [-> null, Expression]) depth
