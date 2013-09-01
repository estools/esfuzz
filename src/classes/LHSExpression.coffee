Identifier = require '../nodes/Identifier'
MemberExpression = require '../nodes/MemberExpression'
{oneOf} = require '../combinators'

# NOTE: this should include CallExpression and NewExpression, but many parsers don't actually allow that
module.exports = oneOf [Identifier, MemberExpression]
