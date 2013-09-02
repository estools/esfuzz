Node = require '../node'
Expression = require '../classes/Expression'
IdentifierName = require './IdentifierName'
{construct, oneOf} = require '../combinators'

class MemberExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @object = Expression depth, ancestors

class DynamicMemberExpression extends MemberExpression
  constructor: (depth, ancestors) ->
    MemberExpression.apply this, arguments
    --depth
    ancestors = [this].concat ancestors
    @property = Expression depth, ancestors
    @computed = true

class StaticMemberExpression extends MemberExpression
  constructor: (depth, ancestors) ->
    MemberExpression.apply this, arguments
    --depth
    ancestors = [this].concat ancestors
    @property = IdentifierName depth, ancestors
    @computed = false

module.exports = oneOf [(construct DynamicMemberExpression), construct StaticMemberExpression]
