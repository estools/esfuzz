escodegen = require 'escodegen'

Program = require './nodes/Program'

class RoundtripFailureError extends Error
  name: 'RoundtripFailureError'
  constructor: (@message) ->
    Error.call this
    Error.captureStackTrace? this, RoundtripFailureError

render = (program) -> escodegen.generate program, format: escodegen.FORMAT_MINIFY

exports.fuzz = (parsers, options) ->
  programAST = Program options.maxDepth ? 8
  try
    program = escodegen.generate programAST, verbatim: 'raw', format: escodegen.FORMAT_MINIFY
    parser.parse program for parser in parsers
  catch err
    err.ast = programAST
    err.js = program
    throw err
  return
