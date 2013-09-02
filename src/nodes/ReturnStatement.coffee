Node = require '../node'
Expression = require '../classes/Expression'
Statement = require '../classes/Statement'
{construct, maybe} = require '../combinators'

returnable = (ancestors) ->
  for ancestor in ancestors when ancestor.type in ['FunctionDeclaration', 'FunctionExpression']
    return true
  false

class ReturnStatement extends Node
  type: @name
  constructor: (depth, ancestors) ->
    --depth
    if depth > 0 and returnable ancestors
      ancestors = [this].concat ancestors
      @argument = (maybe Expression) depth, ancestors
    else
      return Statement 0

module.exports = construct ReturnStatement
