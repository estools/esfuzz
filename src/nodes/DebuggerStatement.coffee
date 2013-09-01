Node = require '../node'
class DebuggerStatement extends Node
  type: @name

module.exports = -> new DebuggerStatement
