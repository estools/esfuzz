Node = require '../node'
Expression = require '../classes/Expression'
IdentifierName = require './IdentifierName'
{construct, oneOf} = require '../combinators'

class MemberExpression extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @object = Expression depth

class DynamicMemberExpression extends MemberExpression
  constructor: (depth) ->
    --depth
    MemberExpression.apply this, arguments
    @property = Expression depth
    @computed = true

class StaticMemberExpression extends MemberExpression
  constructor: (depth) ->
    --depth
    MemberExpression.apply this, arguments
    @property = IdentifierName depth
    @computed = false

module.exports = oneOf [(construct DynamicMemberExpression), construct StaticMemberExpression]
