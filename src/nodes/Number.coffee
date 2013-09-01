Node = require '../node'
{randomInt, randomElement} = require '../random'

class Number_ extends Node
  type: 'Literal'
  constructor: ->
    switch randomInt 6
      when 0
        @value = 0
      when 1
        @value = 0
        @raw = '0.'
      when 2
        @value = 0
        @raw = '.0'
      else
        int = randomInt (Math.pow 2, 53) - 1
        @value = int
        @raw = switch randomInt 10
          when 0 then "#{randomElement ['0', '00', '000', '0000']}#{int.toString 8}"
          when 1 then "0#{randomElement ['x', 'X']}#{int.toString 16}"
          else int.toString()
      # TODO: scientific notation

module.exports = -> new Number_
