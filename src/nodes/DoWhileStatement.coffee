Expression = require '../classes/Expression'
Statement = require '../classes/Statement'

TYPE = 'DoWhileStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  body: Statement depth
  test: Expression depth
