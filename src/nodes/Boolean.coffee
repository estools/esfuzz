Node = require '../node'
{randomBool} = require '../random'

class Boolean extends Node
  type: 'Literal'
  constructor: ->
    @value = randomBool()

module.exports = -> new Boolean
