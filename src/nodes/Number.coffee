Node = require '../node'
{oneOf} = require '../combinators'
{randomInt, randomElement} = require '../random'

class Number_ extends Node
  type: 'Literal'
  constructor: ->
    (oneOf [
      =>
        @value = 0
        do @formatInt
      =>
        @value = randomInt 1e6
        do @formatInt
      =>
        @value = randomInt (Math.pow 2, 53) - 1
        do @formatInt
      =>
        size = randomInt 20
        base = (randomInt 200) / 100
        @raw = "#{base}#{randomElement ['e', 'E']}#{size}"
        @value = parseFloat @raw
      => @value = Math.random()
      =>
        @raw = "#{Math.random()}".slice 1, 3 + randomInt 10
        @value = parseFloat @raw
      => @value = Math.random() * Math.pow 2, 16
    ])()
  formatInt: ->
    switch randomInt 10
      when 0 then @raw = "#{randomElement ['0', '00', '000', '0000']}#{@value.toString 8}"
      when 1 then @raw = "0#{randomElement ['x', 'X']}#{@value.toString 16}"
      when 3 then @raw = "#{@value}."

module.exports = -> new Number_
