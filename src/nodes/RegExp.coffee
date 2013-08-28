{oneOf, listOf} = require '../combinators'
{randomInt} = require '../random'

TYPE = 'Literal'

printableAscii = -> String.fromCharCode 32 + randomInt 94

# turn a character or an escape sequence into a numeric value
charVal = (str) ->
  if str[0] is '\\'
    switch str[1]
      when 'u', 'x'
        parseInt (str.slice 2), 16
      when '0', '1', '2', '3', '4', '5', '6', '7'
        parseInt (str.slice 1), 8
      when 'b' then 8
      when 't' then 9
      when 'n' then 10
      when 'v' then 11
      when 'f' then 12
      when 'r' then 13
      else str.charCodeAt 1
  else
    str.charCodeAt 0

Alternation = (depth) ->
  return '' unless depth--
  ((listOf [Grouping, CharacterClass, Repetition, Sequence]) depth).join '|'

Character = ->
  ch = ''
  ch = printableAscii().replace /[[(){?*+|\\$^]/g, '' until ch
  ch

CharacterClass = (depth) ->
  return '[]' unless depth--
  source = (listOf [printableAscii])().join ''
  source = source.replace /\\/g, '\\\\'
  source = source.replace /]/g, '\\]'
  source = source.replace /(?:^|[^\\])(?:\\\\)*?(\\u[0-9a-fA-F]{4}|\\x[0-9a-fA-F]{2}|\\.|.)-(\\u[0-9a-fA-F]{4}|\\x[0-9a-fA-F]{2}|\\.|.)/g, (match, a, b) ->
    if (charVal a) < (charVal b) then match else "#{b}-#{a}"
  "[#{source}]"

Grouping = (depth) ->
  return '()' unless depth--
  "(#{(RegExpSource) depth})"

Repetition = (depth) ->
  return '' unless depth--
  "#{(oneOf [Grouping, CharacterClass, Character]) depth}#{oneOf ['?', '+', '*', '*?', '+?']}"

Sequence = -> (listOf [Character])().join ''

RegExpSource = (depth) ->
  return '' unless depth--
  (oneOf [Alternation, Grouping, CharacterClass, Repetition, Sequence]) depth


genSafeRegExp = ->
  try
    new RegExp RegExpSource 6
  catch e
    genSafeRegExp()

module.exports = ->
  type: TYPE
  value: genSafeRegExp()
