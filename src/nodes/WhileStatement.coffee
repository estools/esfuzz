Expression = require '../classes/Expression'
Statement = require '../classes/Statement'

TYPE = 'WhileStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  test: Expression depth
  body: Statement depth
