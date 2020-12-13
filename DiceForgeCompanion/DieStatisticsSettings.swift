import Foundation

struct DieStatisticsSettings {
    var rollCount: Int
    var rollType: RollType
    static let defaultSettings = DieStatisticsSettings(rollCount: 1, rollType: .bothDice)
    func statistics(for dieOne: Die, and dieTwo: Die) -> DieStatistics {
        let simulationCount = 20_000
        var counts: Counts
        switch rollType {
        case .leftDie:
            counts = simulateRolls(forDie: dieOne, simulationCount: simulationCount)
        case .rightDie:
            counts = simulateRolls(forDie: dieTwo, simulationCount: simulationCount)
        case .bothDice:
            counts = simulateRolls(forDieOne: dieOne, and: dieTwo, simulationCount: simulationCount)
        }
        let minGold = Double(rollCount) * Double(counts.allCounts.gold) / Double(simulationCount)
        let maxGold =  Double(rollCount) * Double(counts.allCounts.gold + counts.selectOneCounts.gold) / Double(simulationCount)
        
        let minSunShards = Double(rollCount) * Double(counts.allCounts.sunShard) / Double(simulationCount)
        let maxSunShards = Double(rollCount) * Double(counts.allCounts.sunShard + counts.selectOneCounts.sunShard) / Double(simulationCount)
        
        let minMoonShards = Double(rollCount) * Double(counts.allCounts.moonShard) / Double(simulationCount)
        let maxMoonShards = Double(rollCount) * Double(counts.allCounts.moonShard + counts.selectOneCounts.moonShard) / Double(simulationCount)
        
        let minVictoryPoints = Double(rollCount) * Double(counts.allCounts.victoryPoint) / Double(simulationCount)
        let maxVictoryPoints = Double(rollCount) * Double(counts.allCounts.victoryPoint + counts.selectOneCounts.victoryPoint) / Double(simulationCount)
        
        return DieStatistics(expectedGoldCount: (minGold, maxGold),
                             expectedSunShardCount: (minSunShards, maxSunShards),
                             expectedMoonShardCount: (minMoonShards, maxMoonShards),
                             expectedVictoryPointCount: (minVictoryPoints, maxVictoryPoints))
    }
    
    private func simulateRolls(forDie die: Die, simulationCount: Int) -> Counts {
        var counts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
        var selectOneCounts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
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
            case let .selectOne(types):
                for type in types {
                    switch type {
                    case let .gold(val): selectOneCounts.gold += val
                    case let .sunShard(val): selectOneCounts.sunShard += val
                    case let .moonShard(val): selectOneCounts.moonShard += val
                    case let .victory(val): selectOneCounts.victoryPoint += val
                    default: fatalError("Invalid face nesting")
                    }
                }
            default:
                //TODO: Handle remaining cases
                fatalError("Case not handled: \(die.faces.randomElement()!.type)")
            }
        }
        return Counts(allCounts: counts, selectOneCounts: selectOneCounts)
    }
    private func simulateRolls(forDieOne dieOne: Die, and dieTwo: Die, simulationCount: Int) -> Counts {
        var counts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
        var selectOneCounts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int) = (0, 0, 0, 0)
        for _ in 0..<Int(simulationCount) {
            let dieOneFace = dieOne.faces.randomElement()!.type
            let dieTwoFace = dieTwo.faces.randomElement()!.type
            var dieOneIsTimesThree = false
            var dieTwoIsTimesThree = false
            switch dieTwoFace {
            case .timesThree: dieTwoIsTimesThree = true
            default: break
            }
            switch dieOneFace {
            case .timesThree: dieOneIsTimesThree = true
            case .fiveVictoryWithOtherFace: fatalError("TODO")
            case let .gold(val): counts.gold += val * (dieTwoIsTimesThree ? 3 : 1)
            case let .sunShard(val): counts.sunShard += val * (dieTwoIsTimesThree ? 3 : 1)
            case let .moonShard(val): counts.moonShard += val * (dieTwoIsTimesThree ? 3 : 1)
            case let .victory(val): counts.victoryPoint += val * (dieTwoIsTimesThree ? 3 : 1)
            case let .selectAll(types):
                for type in types {
                    switch type {
                    case let .gold(val): counts.gold += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .sunShard(val): counts.sunShard += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .moonShard(val): counts.moonShard += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .victory(val): counts.victoryPoint += val * (dieTwoIsTimesThree ? 3 : 1)
                    default: fatalError("Invalid face nesting")
                    }
                }
            case let .selectOne(types):
                for type in types {
                    switch type {
                    case let .gold(val): selectOneCounts.gold += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .sunShard(val): selectOneCounts.sunShard += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .moonShard(val): selectOneCounts.moonShard += val * (dieTwoIsTimesThree ? 3 : 1)
                    case let .victory(val): selectOneCounts.victoryPoint += val * (dieTwoIsTimesThree ? 3 : 1)
                    default: fatalError("Invalid face nesting")
                    }
                }
            }
            switch dieTwoFace {
            case .timesThree: break
            case .fiveVictoryWithOtherFace: fatalError("TODO")
            case let .gold(val): counts.gold += val * (dieOneIsTimesThree ? 3 : 1)
            case let .sunShard(val): counts.sunShard += val * (dieOneIsTimesThree ? 3 : 1)
            case let .moonShard(val): counts.moonShard += val * (dieOneIsTimesThree ? 3 : 1)
            case let .victory(val): counts.victoryPoint += val * (dieOneIsTimesThree ? 3 : 1)
            case let .selectAll(types):
                for type in types {
                    switch type {
                    case let .gold(val): counts.gold += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .sunShard(val): counts.sunShard += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .moonShard(val): counts.moonShard += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .victory(val): counts.victoryPoint += val * (dieOneIsTimesThree ? 3 : 1)
                    default: fatalError("Invalid face nesting")
                    }
                }
            case let .selectOne(types):
                for type in types {
                    switch type {
                    case let .gold(val): selectOneCounts.gold += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .sunShard(val): selectOneCounts.sunShard += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .moonShard(val): selectOneCounts.moonShard += val * (dieOneIsTimesThree ? 3 : 1)
                    case let .victory(val): selectOneCounts.victoryPoint += val * (dieOneIsTimesThree ? 3 : 1)
                    default: fatalError("Invalid face nesting")
                    }
                }
            }
        }
        return Counts(allCounts: counts, selectOneCounts: selectOneCounts)
    }
}

struct Counts {
    let allCounts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int)
    let selectOneCounts: (gold: Int, sunShard: Int, moonShard: Int, victoryPoint: Int)
}

struct DieStatistics {
    let expectedGoldCount: (min: Double, max: Double)
    let expectedSunShardCount: (min: Double, max: Double)
    let expectedMoonShardCount: (min: Double, max: Double)
    let expectedVictoryPointCount: (min: Double, max: Double)
}

enum RollType: Int {
    case leftDie = 0
    case rightDie = 1
    case bothDice = 2
}
