Node = require '../node'
Pattern = require '../classes/Pattern'
BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'
{randomBool} = require '../random'

class CatchClause extends Node
  type: 'CatchClause'
  guard: null
  constructor: (depth) ->
    @param = Pattern depth
    @body = BlockStatement depth

class TryStatement extends Node
  type: @name
  guardedHandlers: []
  constructor: (depth) ->
    --depth
    @block = BlockStatement depth
    if randomBool()
      @handler = (maybe construct CatchClause) depth
      @finalizer = BlockStatement depth
    else
      @handler = (construct CatchClause) depth
      @finalizer = (maybe BlockStatement) depth

module.exports = construct TryStatement
