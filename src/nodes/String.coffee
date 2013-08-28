{randomInt} = require '../random'

TYPE = 'Literal'

module.exports = ->
  # TODO: this should be 0-65535, but only esprima supports most of these strings
  chars = (String.fromCharCode 32 + randomInt 94 while Math.random() < 0.9)
  type: TYPE
  value: chars.join ''
