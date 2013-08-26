Statement = require '../classes/Statement'
Identifier = require './Identifier'

TYPE = 'LabeledStatement'

# TODO: labels cannot be the same as any ancestor labels
module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  label: Identifier depth
  body: Statement depth
