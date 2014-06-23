Node = require '../node'

class EmptyStatement extends Node
  type: @name

module.exports = -> new EmptyStatement
