Expression = require '../classes/Expression'

TYPE = 'ThrowStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  argument: Expression depth
