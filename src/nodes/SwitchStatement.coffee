Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{oneOf, listOf, listOfAtLeast} = require '../combinators'

SwitchCase = ->
  type: 'SwitchCase'
  test: oneOf Expression
  consequent: listOfAtLeast Statement, 1

# TODO: SwitchCaseFallthrough

SwitchCaseDefault = ->
  type: 'SwitchCase'
  test: null
  consequent: listOfAtLeast Statement, 1

module.exports = ->
  type: 'SwitchStatement'
  discriminant: oneOf Expression
  cases: (listOf [SwitchCase]).concat oneOf [SwitchCaseDefault, -> []]
  lexical: false
