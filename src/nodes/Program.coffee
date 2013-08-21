Statement = require '../classes/Statement'
{listOfAtLeast} = require '../combinators'

module.exports = ->
  type: 'Program'
  body: listOfAtLeast Statement, 1
