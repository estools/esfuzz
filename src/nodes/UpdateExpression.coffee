Node = require '../node'
LHSExpression = require '../classes/LHSExpression'
{construct} = require '../combinators'
{randomBool, randomElement} = require '../random'

OPERATORS = ['++', '--']

class UpdateExpression extends Node
  type: @name
  constructor: (depth) ->
    --depth
    ancestors = [this].concat ancestors
    lhs = LHSExpression depth, ancestors
    # TODO: remove once https://github.com/mishoo/UglifyJS2/issues/284 is fixed
    while lhs.type in ['MemberExpression', 'CallExpression']
      lhs = LHSExpression depth, ancestors
    @operator = randomElement OPERATORS
    @argument = lhs
    @prefix = randomBool()

module.exports = construct UpdateExpression
