{randomInt} = require '../helpers'

# TODO: second code path that generates full range of characters allowed in identifier{Start,Part}
identifierStart = identifierPart = -> String.fromCharCode 97 + randomInt 25

module.exports = ->
  type: 'Identifier'
  name: [identifierStart(), (identifierPart() while Math.random() < 0.8)...].join ''
