Statement = require '../classes/Statement'
Identifier = require './Identifier'
{oneOf, notReserved} = require '../combinators'

# TODO: labels need to be unique per program
module.exports = ->
  type: 'LabeledStatement'
  label: -> notReserved Identifier
  body: oneOf Statement
