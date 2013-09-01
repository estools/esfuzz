{randomBool, randomElement} = require './random'

exports.oneOf = oneOf = (possibleGenerators) ->
  (args...) ->
    (randomElement possibleGenerators) args...

exports.listOf = listOf = (possibleGenerators) ->
  (args...) ->
    while Math.random() < 0.5
      (oneOf possibleGenerators) args...

exports.listOfExactly = listOfExactly = (n, possibleGenerators) ->
  (args...) ->
    ((oneOf possibleGenerators) args... for in [1..n])

exports.listOfAtLeast = (min, possibleGenerators) ->
  (args...) ->
    pre = (listOfExactly min, possibleGenerators)()
    post = (listOf possibleGenerators) args...
    [pre..., post...]

exports.maybe = (generator) ->
  if randomBool() then generator else -> null

exports.construct = (C) -> -> new C arguments...
