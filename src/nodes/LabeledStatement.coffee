Node = require '../node'
Statement = require '../classes/Statement'
Identifier = require './Identifier'
{construct} = require '../combinators'

# TODO: labels cannot be the same as any ancestor labels
class LabeledStatement extends Node
  type: @name
  constructor: (depth) ->
    --depth
    @label = Identifier depth
    @body = Statement depth

module.exports = construct LabeledStatement
