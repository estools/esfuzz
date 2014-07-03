Node = require '../node'
LHSExpression = require '../classes/LHSExpression'
{construct} = require '../combinators'
{randomBool, randomElement} = require '../random'

OPERATORS = ['++', '--']

class UpdateExpression extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @operator = randomElement OPERATORS
    @argument = LHSExpression depth, ancestors
    @prefix = randomBool()

module.exports = construct UpdateExpression
