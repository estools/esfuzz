Node = require '../node'
Statement = require '../classes/Statement'
Expression = require '../classes/Expression'
{construct, oneOf, listOf, listOfAtLeast} = require '../combinators'

class SwitchCase extends Node
  type: 'SwitchCase'
  constructor: (depth, ancestors) ->
    ancestors = [this].concat ancestors
    @test = Expression depth, ancestors
    @consequent = (listOfAtLeast 1, [Statement]) depth, ancestors

# TODO: SwitchCaseFallthrough

class SwitchCaseDefault extends Node
  type: 'SwitchCase'
  test: null
  constructor: (depth, ancestors) ->
    ancestors = [this].concat ancestors
    @consequent = (listOfAtLeast 1, [Statement]) depth, ancestors

class SwitchStatement extends Node
  type: @name
  cases: []
  lexical: false
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0
      ancestors = [this].concat ancestors
      @discriminant = Expression depth, ancestors
      @cases = ((listOf [construct SwitchCase]) depth, ancestors).concat (oneOf [(construct SwitchCaseDefault), -> []]) depth, ancestors
    else
      @discriminant = Expression 0

module.exports = construct SwitchStatement
