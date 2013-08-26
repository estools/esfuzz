Expression = require '../classes/Expression'
{maybe, oneOf} = require '../combinators'

TYPE = 'ReturnStatement'

# TODO: return can only exist within functions
module.exports = (depth) ->
  --depth
  type: TYPE
  argument: (maybe Expression) depth
