{oneOf} = require '../combinators'
{randomInt} = require '../helpers'

# TODO: Boolean, RegExp

Number_ = -> (oneOf [
  -> type: 'Literal', value: 0
  -> type: 'Literal', value: 0, raw: '0.'
  -> type: 'Literal', value: 0, raw: '.0'
  ->
    int = randomInt (Math.pow 2, 53) - 1
    type: 'Literal', value: int
    # TODO: re-enable when https://github.com/Constellation/escodegen/issues/123 is fixed
    #type: 'Literal', value: int, raw: switch randomInt 10
    #  when 0 then "#{oneOf ['0', '00', '000', '0000']}#{int.toString 8}"
    #  when 1 then "0#{oneOf ['x', 'X']}#{int.toString 16}"
    #  else int.toString()
  # TODO: scientific notation
])()

String_ = ->
  # TODO: this should be 0-65535, but only esprima supports most of these strings
  chars = (String.fromCharCode 32 + randomInt 94 while Math.random() < 0.95)
  type: 'Literal', value: chars.join ''

Null = -> type: 'Literal', value: null

module.exports = -> (oneOf [Number_, String_, Null])()
