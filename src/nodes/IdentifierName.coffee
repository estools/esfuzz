RESERVED = require '../reserved'
UNRESERVED = require '../unreserved'
{randomInt, randomElement} = require '../helpers'

# TODO: generate full range of characters allowed in identifier{Start,Part}
identifierStart = identifierPart = -> String.fromCharCode 97 + randomInt 25

problematicNames = [RESERVED..., UNRESERVED...]

module.exports = ->
  if Math.random() < 1/10
    type: 'Identifier'
    name: randomElement problematicNames
  else
    type: 'Identifier'
    name: [identifierStart(), (identifierPart() while Math.random() < 0.8)...].join ''
