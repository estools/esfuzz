Node = require '../node'
Pattern = require '../classes/Pattern'
BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{construct, maybe} = require '../combinators'
{randomBool} = require '../random'

class CatchClause extends Node
  type: 'CatchClause'
  guard: null
  constructor: (depth, ancestors) ->
    ancestors = [this].concat ancestors
    @param = Pattern depth, ancestors
    @body = BlockStatement depth, ancestors

class TryStatement extends Node
  type: @name
  guardedHandlers: []
  constructor: (depth, ancestors) ->
    --depth
    ancestors = [this].concat ancestors
    @block = BlockStatement depth, ancestors
    if randomBool()
      @handler = (maybe construct CatchClause) depth, ancestors
      @finalizer = BlockStatement depth, ancestors
    else
      @handler = (construct CatchClause) depth, ancestors
      @finalizer = (maybe BlockStatement) depth, ancestors

module.exports = construct TryStatement
