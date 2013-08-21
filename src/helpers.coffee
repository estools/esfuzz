exports.randomInt = randomInt = (max) -> Math.floor(Math.random() * (max + 1))
exports.randomElement = (list) -> list[randomInt list.length - 1]
