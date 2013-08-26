Expression = require '../classes/Expression'
IdentifierName = require './IdentifierName'
{oneOf} = require '../combinators'

TYPE = 'MemberExpression'

DynamicMemberExpression = (depth) ->
  type: TYPE
  object: Expression depth
  property: Expression depth
  computed: true

StaticMemberExpression = (depth) ->
  type: TYPE
  object: Expression depth
  property: IdentifierName depth
  computed: false

module.exports = (depth) ->
  --depth
  (oneOf [DynamicMemberExpression, StaticMemberExpression]) depth
