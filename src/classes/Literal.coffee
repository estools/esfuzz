Boolean_ = require '../nodes/Boolean'
Null = require '../nodes/Null'
Number_ = require '../nodes/Number'
String_ = require '../nodes/String'
{oneOf} = require '../combinators'

# TODO: RegExp
module.exports = (args...) -> (oneOf [Boolean_, Null, Number_, String_]) args...
