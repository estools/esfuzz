Expression = require '../classes/Expression'
FunctionExpression = require './FunctionExpression'
IdentifierName = require './IdentifierName'
Identifier = require './Identifier'
Number_ = require './Number'
String_ = require './String'
{construct, oneOf, listOf} = require '../combinators'

nubBy = (xs, eq) ->
  x for x in xs when not (y for y in xs when eq x, y).length

propName = (node) -> switch node.type
  when 'Literal' then "#{node.value}"
  when 'Identifier' then node.name

eq = (x, y) ->
  (propName x) is (propName y) and (
    x.kind is y.kind and x.kind in ['get', 'set'] or
    x.kind is 'init' and y.kind in ['get', 'set'] or
    y.kind is 'init' and x.kind in ['get', 'set']
  )

Key = (args...) -> (oneOf [String_, Number_, IdentifierName]) args...

Property = (depth) ->
  kind: 'init'
  key: Key depth
  value: Expression depth

Getter = (depth) ->
  fn = FunctionExpression depth
  fn.params.length = 0
  kind: 'get'
  key: Key depth
  value: fn

Setter = (depth) ->
  fn = FunctionExpression depth
  fn.params = [Identifier depth]
  kind: 'set'
  key: Key depth
  value: fn

class ObjectExpression
  type: @name
  properties: []
  constructor: (depth) ->
    --depth
    if depth > 0
      @properties = nubBy ((listOf [Property, Getter, Setter]) depth), eq

module.exports = construct ObjectExpression
