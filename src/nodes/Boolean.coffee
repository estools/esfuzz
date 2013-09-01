{randomBool} = require '../random'
{construct} = require '../combinators'

class Boolean
  type: 'Literal'
  constructor: ->
    @value = randomBool()

module.exports = construct Boolean
