Identifier = require '../nodes/Identifier'
{oneOf} = require '../combinators'

# TODO: also MemberExpression
module.exports = -> oneOf [Identifier]
