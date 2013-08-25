RESERVED = require './reserved'
{randomBool, randomElement} = require './helpers'


exports.listOf = listOf = (possibleGenerators) ->
  while Math.random() < 0.4
    oneOf possibleGenerators

exports.listOfAtLeast = (possibleGenerators, min) ->
  (oneOf possibleGenerators for _ in [1..min]).concat listOf possibleGenerators

exports.oneOf = oneOf = (possibleGenerators) ->
  (randomElement possibleGenerators)()

exports.maybe = (generator) ->
  if randomBool() then generator() else null

exports.notReserved = (generator) ->
  id = generator()
  id.name = if id.name in RESERVED then "#{id.name}_" else id.name
  id

