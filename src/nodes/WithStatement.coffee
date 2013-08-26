Statement = require '../classes/Statement'
Expression = require '../classes/Expression'

TYPE = 'WithStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  object: Expression depth
  body: Statement depth
