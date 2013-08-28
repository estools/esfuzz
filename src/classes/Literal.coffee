Boolean_ = require '../nodes/Boolean'
Null = require '../nodes/Null'
Number_ = require '../nodes/Number'
RegExp_ = require '../nodes/RegExp'
String_ = require '../nodes/String'
{oneOf} = require '../combinators'

module.exports = (args...) -> (oneOf [Boolean_, Null, Number_, RegExp_, String_]) args...
