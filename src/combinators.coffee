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
