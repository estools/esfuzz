Identifier = require '../nodes/Identifier'
MemberExpression = require '../nodes/MemberExpression'
{oneOf} = require '../combinators'

module.exports = -> oneOf [Identifier, MemberExpression]
