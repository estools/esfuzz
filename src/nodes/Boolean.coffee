Node = require '../node'
{randomBool} = require '../random'
{construct} = require '../combinators'

class Boolean extends Node
  type: 'Literal'
  constructor: ->
    @value = randomBool()

module.exports = construct Boolean
