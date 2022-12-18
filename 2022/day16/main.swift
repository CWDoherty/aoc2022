import CoreData
import Foundation

var input = try String(contentsOfFile: "./input.txt")
input.removeLast();

var valveMap: [String:(String, Int, [String])] = [:];
input.components(separatedBy: "\n").forEach {
    let valveParts = $0.components(separatedBy: " ")
    let id = valveParts[1]
    let flowRate = Int(valveParts[4].components(separatedBy: "=")[1].components(separatedBy: ";")[0])!
    let tunnels = $0.components(separatedBy: "to valve")[1]
        .replacingOccurrences(of: "s", with: "")
        .replacingOccurrences(of: " ", with: "")
        .components(separatedBy: ",")

    valveMap[id] = (id, flowRate, tunnels)
}

let nonZeroValves = Set(valveMap.keys.filter {
    valveMap[$0]!.1 > 0
})


func getDistances() -> [String: [String: Int]] {
    var distanceMap: [String: [String:Int]] = [:]
    Array(valveMap.keys).forEach {
        var distances: [String:Int] = [:]
        valveMap.keys.forEach {
            distances[$0] = Int.max
        }
        distances[$0] = 0
        var toVisit = [$0]

        while (!toVisit.isEmpty) {
            let current = toVisit.remove(at: 0)
            valveMap[current]!.2.forEach {
                let newDistance = distances[current]! + 1
                if (newDistance < distances[$0]!) {
                    distances[$0] = newDistance
                    toVisit.append($0)
                }
            }
        }
        distanceMap[$0] = distances;
    }
    return distanceMap
}

var calls = 0;

func traversePipes(minutes: Int, currentValve: String, unOpenedValves: Set<String>, pressure: Int) -> Int {
    let score = minutes * valveMap[currentValve]!.1;
    let distances = getDistances()
    let validDistances = unOpenedValves.filter { distances[currentValve]![$0]! < minutes }

    if (validDistances.isEmpty) {
        return score
    }

    return score + validDistances.map {
        let newMinutes = minutes - 1 - distances[currentValve]![$0]!
        var unOpenedValvesCopy = unOpenedValves
        unOpenedValvesCopy.remove($0)
        return traversePipes(minutes: newMinutes, currentValve: $0, unOpenedValves: unOpenedValvesCopy, pressure: score)
    }.max()!
}

let result = traversePipes(minutes: 30, currentValve: "AA", unOpenedValves: nonZeroValves, pressure: 0)
print(result)
