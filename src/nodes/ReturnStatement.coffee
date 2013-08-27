Expression = require '../classes/Expression'
{maybe} = require '../combinators'

TYPE = 'ReturnStatement'

# TODO: return can only exist within functions
module.exports = (depth) ->
  --depth
  type: TYPE
  argument: (maybe Expression) depth
