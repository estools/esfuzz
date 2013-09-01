RESERVED = require '../reserved'
UNRESERVED = require '../unreserved'
{randomInt, randomElement} = require '../random'
{construct} = require '../combinators'

PROBLEMATIC_NAMES = [RESERVED..., UNRESERVED...]

# TODO: generate full range of characters allowed in identifier{Start,Part}
identifierStart = identifierPart = -> String.fromCharCode 97 + randomInt 25

class Identifier
  type: @name
  constructor: ->
    if Math.random() < 1/10
      @name = randomElement PROBLEMATIC_NAMES
    else
      @name = [identifierStart(), (identifierPart() while Math.random() < 0.8)...].join ''

module.exports = construct Identifier
