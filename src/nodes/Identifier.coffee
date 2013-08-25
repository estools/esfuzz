IdentifierName = require './IdentifierName'
RESERVED = require '../reserved'

notReserved = (generator) ->
  id = generator()
  id.name = if id.name in RESERVED then "#{id.name}_" else id.name
  id

module.exports = -> notReserved IdentifierName
