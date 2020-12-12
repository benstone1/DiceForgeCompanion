import Foundation

struct DieStatisticsSettings {
    var rollCount: Int
    var rollType: RollType
    static let defaultSettings = DieStatisticsSettings(rollCount: 1, rollType: .bothDice)
}

enum RollType: Int {
    case leftDie = 0
    case rightDie = 1
    case bothDice = 2
}
