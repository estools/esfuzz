Expression = require '../classes/Expression'
{maybe, listOf} = require '../combinators'

TYPE = 'ArrayExpression'

module.exports = (depth) ->
  --depth
  type: TYPE
  elements: (listOf [maybe Expression]) depth
