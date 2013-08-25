Statement = require '../classes/Statement'
Identifier = require './Identifier'
{oneOf} = require '../combinators'

# TODO: labels need to be unique per program
module.exports = ->
  type: 'LabeledStatement'
  label: Identifier()
  body: oneOf Statement
