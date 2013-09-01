Node = require '../node'

class Null extends Node
  type: 'Literal'
  value: null

module.exports = -> new Null
