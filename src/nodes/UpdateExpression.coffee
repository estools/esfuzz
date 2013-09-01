LHSExpression = require '../classes/LHSExpression'
{construct} = require '../combinators'
{randomBool, randomElement} = require '../random'

OPERATORS = ['++', '--']

class UpdateExpression
  type: @name
  constructor: (depth) ->
    --depth
    @operator = randomElement OPERATORS
    @argument = LHSExpression depth
    @prefix = randomBool()

module.exports = construct UpdateExpression
