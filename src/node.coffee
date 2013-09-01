module.exports = class Node
  toJSON: ->
    memo = {@type}
    memo[p] = @constructor::[p] for own p of @constructor.prototype
    memo[p] = this[p] for own p of this
    memo
  toString: -> JSON.stringify this
