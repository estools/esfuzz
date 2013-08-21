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
  program = escodegen.generate programAST, verbatim: 'raw', format: escodegen.FORMAT_MINIFY
  try
    roundTrippedPrograms = (render parser.parse program for parser in parsers)
  catch err
    err.ast = programAST
    err.js = program
    throw err
  targetProgram = render programAST
  for roundTrippedProgram in roundTrippedPrograms when roundTrippedProgram isnt targetProgram
    err = new RoundtripFailureError
    err.ast = programAST
    err.js = program
    throw err
  return
