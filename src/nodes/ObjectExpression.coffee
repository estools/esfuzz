Node = require '../node'
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

Key = oneOf [String_, Number_, IdentifierName]

Property = ->
  kind: 'init'
  key: Key arguments...
  value: Expression arguments...

Getter = ->
  fn = FunctionExpression arguments...
  fn.params.length = 0
  kind: 'get'
  key: Key arguments...
  value: fn

Setter = ->
  fn = FunctionExpression arguments...
  fn.params = [Identifier arguments...]
  kind: 'set'
  key: Key arguments...
  value: fn

class ObjectExpression extends Node
  type: @name
  properties: []
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0
      ancestors = [this].concat ancestors
      @properties = nubBy ((listOf [Property, Getter, Setter]) depth, ancestors), eq

module.exports = construct ObjectExpression
