{randomBool, randomElement} = require './helpers'

exports.listOf = listOf = (possibleGenerators) ->
  (args...) ->
    while Math.random() < 0.5
      (oneOf possibleGenerators) args...

exports.listOfAtLeast = (min, possibleGenerators) ->
  (args...) ->
    pre = ((oneOf possibleGenerators) args... for _ in [1..min])
    post = (listOf possibleGenerators) args...
    [pre..., post...]

exports.oneOf = oneOf = (possibleGenerators) ->
  randomElement possibleGenerators

exports.maybe = (generator) ->
  if randomBool() then generator else -> null
