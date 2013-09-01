Node = require '../node'
{oneOf, listOf, listOfExactly} = require '../combinators'
{randomInt, randomElement} = require '../random'

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

Hex = do ->
  chars = '0123456789abcdefABCDEF'.split ''
  -> randomElement chars

Character = ->
  (oneOf [
    ->
      loop
        ch = printableAscii()
        return ch unless ch in ['[', '(', ')', '{', '?', '*', '+', '|', '\\', '$', '^']
      return
    -> "\\u#{(listOfExactly 4, [Hex])().join ''}"
    -> "\\x#{(listOfExactly 2, [Hex])().join ''}"
    ->
      loop
        ch = printableAscii()
        return "\\#{ch}" unless ch in ['u', 'x', 'b', 'B', 'c', '1', '2', '3', '4', '5', '6', '7', '8', '9']
      return
  ])()

Boundary = -> randomElement ['^', '$', '\\b', '\\B']

CharacterClassCharacter = ->
  ch = '-'
  while ch in ['-', ']']
    ch = (oneOf [Character, -> randomElement ['[', '(', ')', '{', '?', '*', '+', '|', '$']])()
  ch

CharacterClassRange = ->
  a = CharacterClassCharacter()
  b = CharacterClassCharacter()
  [left, right] = if (charVal a) < (charVal b) then [a, b] else [b, a]
  "#{left}-#{right}"

CharacterClass = (depth) ->
  return '[]' unless depth--
  source = (listOf [CharacterClassCharacter, CharacterClassRange])().join ''
  source = source.replace /\\$/g, '\\a'
  "[#{randomElement ['^', '-', '']}#{source}#{randomElement ['-', '']}]"

Grouping = (depth) ->
  return '()' unless depth--
  "(#{randomElement ['?:', '?!', '?=', '']}#{RegExpSource depth})"

Repetition = (depth) ->
  return '' unless depth--
  "#{(oneOf [Grouping, CharacterClass, Character]) depth}#{randomElement ['?', '+', '*', '*?', '+?']}"

Sequence = -> (listOf [Character, Boundary])().join ''

RegExpSource = (depth) ->
  return '' unless depth--
  (oneOf [Alternation, Grouping, CharacterClass, Repetition, Sequence]) depth


class RegExp_ extends Node
  type: 'Literal'
  constructor: (depth) ->
    @value = new RegExp RegExpSource 8

module.exports = -> new RegExp_ arguments...
