Expression = require '../classes/Expression'
IdentifierName = require './IdentifierName'
Number_ = require './Number'
String_ = require './String'
{oneOf} = require '../combinators'

TYPE = 'ObjectExpression'
leaf = (depth) -> type: TYPE, properties: []

Key = (args...) -> (oneOf [String_, Number_, IdentifierName]) args...

Property = (depth) ->
  kind: 'init'
  key: Key depth
  value: Expression depth

# TODO: getters/setters

module.exports = (depth) ->
  --depth
  type: TYPE
  properties: (listOf [Property]) depth
