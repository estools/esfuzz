Node = require '../node'
{randomInt} = require '../random'

class String_ extends Node
  type: 'Literal'
  constructor: ->
    # TODO: this should be 0-65535, but only esprima supports most of these strings
    @value = (String.fromCharCode 32 + randomInt 94 while Math.random() < 0.9).join ''

module.exports = -> new String_
