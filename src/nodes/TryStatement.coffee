BlockStatement = require './BlockStatement'
Identifier = require './Identifier'
{oneOf, maybe} = require '../combinators'

TYPE = 'TryStatement'

CatchClause = (depth) ->
  type: 'CatchClause'
  param: Identifier depth
  guard: null
  body: BlockStatement depth

TryStatementMaybeCatch = (depth) ->
  type: TYPE
  block: BlockStatement depth
  handler: (maybe CatchClause) depth
  guardedHandlers: []
  finalizer: BlockStatement depth

TryStatementMaybeFinally = (depth) ->
  type: TYPE
  block: BlockStatement depth
  handler: CatchClause depth
  guardedHandlers: []
  finalizer: (maybe BlockStatement) depth

module.exports = (depth) ->
  --depth
  (oneOf [TryStatementMaybeCatch, TryStatementMaybeFinally]) depth
