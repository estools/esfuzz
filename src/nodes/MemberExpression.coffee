Expression = require '../classes/Expression'
IdentifierName = require './IdentifierName'
{oneOf} = require '../combinators'

DynamicMemberExpression = ->
  type: 'MemberExpression'
  object: oneOf Expression
  property: oneOf Expression
  computed: true

StaticMemberExpression = ->
  type: 'MemberExpression'
  object: oneOf Expression
  property: IdentifierName()
  computed: false

module.exports = -> oneOf [DynamicMemberExpression, StaticMemberExpression]
