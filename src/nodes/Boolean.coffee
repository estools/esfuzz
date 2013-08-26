{oneOf} = require '../combinators'

module.exports = -> type: 'Literal', value: oneOf [true, false]
