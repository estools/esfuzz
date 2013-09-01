Node = require '../node'
{construct} = require '../combinators'

class ThisExpression extends Node
  type: @name

module.exports = construct ThisExpression
