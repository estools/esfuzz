Expression = require '../classes/Expression'
Identifier = require './Identifier'
{maybe, listOfAtLeast} = require '../combinators'

TYPE = 'VariableDeclaration'

VariableDeclarator = (depth) ->
  type: 'VariableDeclarator'
  id: Identifier depth # TODO: use Pattern instead
  init: (maybe Expression) depth

module.exports = (depth) ->
  --depth
  type: TYPE
  declarations: (listOfAtLeast 1, [VariableDeclarator]) depth
  kind: 'var' # TODO: let/const
