Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{maybe} = require '../combinators'

TYPE = 'IfStatement'

module.exports = (depth) ->
  --depth
  type: TYPE
  test: Expression depth
  consequent: Statement depth
  alternate: (maybe Statement) depth
