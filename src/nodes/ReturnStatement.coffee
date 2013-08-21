Expression = require '../classes/Expression'
{maybe, oneOf} = require '../combinators'

# TODO: return can only exist within functions
module.exports = ->
  type: 'ReturnStatement'
  argument: maybe -> oneOf Expression
