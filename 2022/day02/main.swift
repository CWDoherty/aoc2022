import CoreData
import Foundation

let input = try String(contentsOfFile: "./input.txt")
var rpsGames = input.components(separatedBy: "\n")
rpsGames.removeLast()

let decrypted = [
  "X": "A",
  "Y": "B",
  "Z": "C",
]

let scores = [
  "A": 1,
  "B": 2,
  "C": 3,
]

let rankings = [
  "A": "C",
  "B": "A",
  "C": "B",
]

let rankingsPartTwo = [
  "A": ["B", "C"],
  "B": ["C", "A"],
  "C": ["A", "B"],
]

var partOneScore = 0
var partTwoScore = 0


for game in rpsGames {
  let choices = game.components(separatedBy: " ")
  let opponentChoice = choices[0]
  let myChoice = decrypted[choices[1]]!

  // Part 1
  if opponentChoice == myChoice {
    partOneScore += 3
    partOneScore += scores[myChoice]!
  } else if rankings[opponentChoice]! == myChoice {
    partOneScore += scores[myChoice]!
  } else {
    partOneScore += 6
    partOneScore += scores[myChoice]!
  }

  // Part 2
  let myChoicePartTwo = choices[1]

  if (myChoicePartTwo == "Y") {
    partTwoScore += 3
    partTwoScore += scores[opponentChoice]!
  } else if (myChoicePartTwo == "X") { // Lost
    partTwoScore += scores[rankingsPartTwo[opponentChoice]![1]]!
  } else {
    partTwoScore += 6
    partTwoScore += scores[rankingsPartTwo[opponentChoice]![0]]!
  }
}


print("Part 1: \(partOneScore)")
print("Part 1: \(partTwoScore)")
