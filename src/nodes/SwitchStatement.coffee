Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{oneOf, listOf, listOfAtLeast} = require '../combinators'

TYPE = 'SwitchStatement'
leaf = ->
  type: TYPE
  discriminant: Expression 0
  cases: []
  lexical: false

SwitchCase = (depth) ->
  type: 'SwitchCase'
  test: Expression depth
  consequent: (listOfAtLeast 1, [Statement]) depth

# TODO: SwitchCaseFallthrough

SwitchCaseDefault = (depth) ->
  type: 'SwitchCase'
  test: null
  consequent: (listOfAtLeast 1, [Statement]) depth

module.exports = (depth) ->
  return leaf() unless depth-- > 0
  type: TYPE
  discriminant: Expression depth
  cases: ((listOf [SwitchCase]) depth).concat (oneOf [SwitchCaseDefault, -> []]) depth
  lexical: false
