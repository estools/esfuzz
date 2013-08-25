escodegen = require 'escodegen'

Program = require './nodes/Program'

class RoundtripFailureError extends Error
  name: 'RoundtripFailureError'
  constructor: (@message) ->
    Error.call this
    Error.captureStackTrace? this, RoundtripFailureError

render = (program) -> escodegen.generate program, format: escodegen.FORMAT_MINIFY

exports.fuzz = (parsers) ->
  programAST = Program()
  try
    program = escodegen.generate programAST, verbatim: 'raw', format: escodegen.FORMAT_MINIFY
    roundTrippedPrograms = (render parser.parse program for parser in parsers)
    targetProgram = render programAST
  catch err
    err.ast = programAST
    err.js = program
    throw err
  for roundTrippedProgram in roundTrippedPrograms when roundTrippedProgram isnt targetProgram
    err = new RoundtripFailureError
    err.ast = programAST
    err.js = program
    throw err
  return
