import Foundation

struct DieStatisticsSettings {
    var rollCount: Int
    var rollType: RollType
    static let defaultSettings = DieStatisticsSettings(rollCount: 1, rollType: .bothDice)
    func statistics(for dieOne: Die, and dieTwo: Die) -> DieStatistics {
        let simulationCount = 20_000
        var counts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
        switch rollType {
        case .leftDie:
            counts = simulateRolls(forDie: dieOne, simulationCount: simulationCount)
        case .rightDie:
            counts = simulateRolls(forDie: dieTwo, simulationCount: simulationCount)
        case .bothDice:
            //TODO: Refactor to handle x3 and 5victory split
            let leftCounts = simulateRolls(forDie: dieOne, simulationCount: simulationCount)
            let rightCounts = simulateRolls(forDie: dieTwo, simulationCount: simulationCount)
            counts = (leftCounts.gold + rightCounts.gold, leftCounts.sunShard + rightCounts.sunShard, leftCounts.moonShard + rightCounts.moonShard, leftCounts.victoryPoint + rightCounts.victoryPoint)
        }
        return DieStatistics(expectedGoldCount: Double(rollCount) * Double(counts.gold) / Double(simulationCount),
                             expectedSunShardCount: Double(rollCount) * Double(counts.sunShard) / Double(simulationCount),
                             expectedMoonShardCount: Double(rollCount) * Double(counts.moonShard) / Double(simulationCount),
                             expectedVictoryPointCount: Double(rollCount) * Double(counts.victoryPoint) / Double(simulationCount))
    }
    private func simulateRolls(forDie die: Die, simulationCount: Int) -> (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) {
        var counts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
        for _ in 0..<Int(simulationCount) {
            switch die.faces.randomElement()!.type {
            case let .gold(val): counts.gold += val
            case let .sunShard(val): counts.sunShard += val
            case let .moonShard(val): counts.moonShard += val
            case let .victory(val): counts.victoryPoint += val
            case let .selectAll(types):
                for type in types {
                    switch type {
                    case let .gold(val): counts.gold += val
                    case let .sunShard(val): counts.sunShard += val
                    case let .moonShard(val): counts.moonShard += val
                    case let .victory(val): counts.victoryPoint += val
                    default: fatalError("Invalid face nesting")
                    }
                }
            default:
                //TODO: Handle remaining cases
                fatalError("Case not handled: \(die.faces.randomElement()!.type)")
            }
        }
        return counts
    }
}

struct DieStatistics {
    let expectedGoldCount: Double
    let expectedSunShardCount: Double
    let expectedMoonShardCount: Double
    let expectedVictoryPointCount: Double
}

enum RollType: Int {
    case leftDie = 0
    case rightDie = 1
    case bothDice = 2
}
