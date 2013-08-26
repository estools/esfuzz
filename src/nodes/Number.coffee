{oneOf} = require '../combinators'
{randomInt} = require '../helpers'

TYPE = 'Literal'

module.exports = -> (oneOf [
  -> type: TYPE, value: 0
  -> type: TYPE, value: 0, raw: '0.'
  -> type: TYPE, value: 0, raw: '.0'
  ->
    int = randomInt (Math.pow 2, 53) - 1
    type: TYPE
    value: int
    raw: switch randomInt 10
      when 0 then "#{oneOf ['0', '00', '000', '0000']}#{int.toString 8}"
      when 1 then "0#{oneOf ['x', 'X']}#{int.toString 16}"
      else int.toString()
  # TODO: scientific notation
])()
