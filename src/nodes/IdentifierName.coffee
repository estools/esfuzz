RESERVED = require '../reserved'
UNRESERVED = require '../unreserved'
{oneOf} = require '../combinators'
{randomInt} = require '../helpers'

TYPE = 'Identifier'
PROBLEMATIC_NAMES = [RESERVED..., UNRESERVED...]

# TODO: generate full range of characters allowed in identifier{Start,Part}
identifierStart = identifierPart = -> String.fromCharCode 97 + randomInt 25

module.exports = ->
  if Math.random() < 1/10
    type: TYPE
    name: oneOf PROBLEMATIC_NAMES
  else
    type: TYPE
    name: [identifierStart(), (identifierPart() while Math.random() < 0.8)...].join ''
