Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct, oneOf, listOf, listOfAtLeast} = require '../combinators'

class SwitchCase
  type: 'SwitchCase'
  constructor: (depth) ->
    @test = Expression depth
    @consequent = (listOfAtLeast 1, [Statement]) depth

# TODO: SwitchCaseFallthrough

class SwitchCaseDefault
  type: 'SwitchCase'
  test: null
  constructor: (depth) ->
    @consequent = (listOfAtLeast 1, [Statement]) depth

class SwitchStatement
  type: @name
  cases: []
  lexical: false
  constructor: (depth) ->
    --depth
    if depth > 0
      @discriminant = Expression depth
      @cases = ((listOf [construct SwitchCase]) depth).concat (oneOf [(construct SwitchCaseDefault), -> []]) depth
    else
      @discriminant = Expression 0

module.exports = construct SwitchStatement
