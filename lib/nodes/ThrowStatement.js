// Generated by CoffeeScript 2.0.0-beta5
void function () {
  var Expression, TYPE;
  Expression = require('../classes/Expression');
  TYPE = 'ThrowStatement';
  module.exports = function (depth) {
    --depth;
    return {
      type: TYPE,
      argument: Expression(depth)
    };
  };
}.call(this);