import UIKit

struct Die {
    let faces: [DieFace]
    init(faces: [DieFace]) {
        self.faces = faces
    }
    static let startingDieOne = Die(faces: [
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneSun")!, type: .sunShard(1)),
    ])
    static let startingDieTwo = Die(faces: [
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "oneMoon")!, type: .moonShard(1)),
        DieFace(image: UIImage(named: "twoVictory")!, type: .victory(2)),
    ])
}

struct DieFace {
    let image: UIImage
    let type: DieFaceType
    static let allFaces: [DieFace] = [
        DieFace(image: UIImage(named: "oneGold")!, type: .gold(1)),
        DieFace(image: UIImage(named: "threeGold")!, type: .gold(3)),
        DieFace(image: UIImage(named: "fourGold")!, type: .gold(4)),
        DieFace(image: UIImage(named: "sixGold")!, type: .gold(6)),
        DieFace(image: UIImage(named: "oneSun")!, type: .sunShard(1)),
        DieFace(image: UIImage(named: "twoSun")!, type: .sunShard(2)),
        DieFace(image: UIImage(named: "oneMoon")!, type: .moonShard(1)),
        DieFace(image: UIImage(named: "twoMoon")!, type: .moonShard(2)),
        DieFace(image: UIImage(named: "twoVictory")!, type: .victory(2)),
        DieFace(image: UIImage(named: "threeVictory")!, type: .victory(3)),
        DieFace(image: UIImage(named: "fourVictory")!, type: .victory(4)),
        DieFace(image: UIImage(named: "oneGoldOneSunOneMoonOneVictory")!, type: .selectAll([.gold(1), .sunShard(1), .moonShard(1), .victory(1)])),
        DieFace(image: UIImage(named: "oneSunOneVictory")!, type: .selectAll([.sunShard(1), .victory(1)])),
        DieFace(image: UIImage(named: "twoGoldOneMoon")!, type: .selectAll([.gold(2), .moonShard(1)])),
        DieFace(image: UIImage(named: "twoMoonTwoVictory")!, type: .selectAll([.moonShard(2), .victory(2)])),
        DieFace(image: UIImage(named: "orThreeGoldTwoVictory")!, type: .selectOne([.gold(3), .victory(2)])),
        DieFace(image: UIImage(named: "orOneGoldOneSunOneMoon")!, type: .selectOne([.gold(1), .sunShard(1), .moonShard(1)])),
        DieFace(image: UIImage(named: "orTwoGoldTwoSunTwoMoon")!, type: .selectOne([.gold(2), .sunShard(2), .moonShard(2)])),
        DieFace(image: UIImage(named: "timesThree")!, type: .timesThree),
        DieFace(image: UIImage(named: "fiveVictorySplitThreeGold")!, type: .fiveVictoryWithOtherFace(.gold(3))),
        DieFace(image: UIImage(named: "fiveVictorySplitThreeVictory")!, type: .fiveVictoryWithOtherFace(.victory(3))),
        DieFace(image: UIImage(named: "fiveVictorySplitTwoMoon")!, type: .fiveVictoryWithOtherFace(.moonShard(2))),
        DieFace(image: UIImage(named: "fiveVictorySplitTwoSun")!, type: .fiveVictoryWithOtherFace(.sunShard(2))),
        DieFace(image: UIImage(named: "boarOrOneSunOneMoon")!, type: .selectOne([.sunShard(1), .moonShard(1)])),
    ]
}

indirect enum DieFaceType {
    case gold(Int)
    case sunShard(Int)
    case moonShard(Int)
    case victory(Int)
    case selectOne([DieFaceType])
    case selectAll([DieFaceType])
    case timesThree
    case fiveVictoryWithOtherFace(DieFaceType)
    func isOptionallySameType(as otherFace: DieFaceType) -> Bool {
        switch self {
        case let .fiveVictoryWithOtherFace(face):
            switch face {
            case .gold:
                switch otherFace {
                case let .selectOne(types):
                    for type in types {
                        switch type {
                        case .gold: return true
                        default: break
                        }
                    }
                default: return false
                }
            case .sunShard:
                switch otherFace {
                case let .selectOne(types):
                    for type in types {
                        switch type {
                        case .sunShard: return true
                        default: break
                        }
                    }
                default: return false
                }
            case .moonShard:
                switch otherFace {
                case let .selectOne(types):
                    for type in types {
                        switch type {
                        case .moonShard: return true
                        default: break
                        }
                    }
                default: return false
                }
            case .victory:
                switch otherFace {
                case let .selectOne(types):
                    for type in types {
                        switch type {
                        case .victory: return true
                        default: break
                        }
                    }
                default: return false
                }
            default: return false
            }
        default: fatalError("Checking only supported for 5/split face")
        }
        return false
    }
    func isSameType(as otherFace: DieFaceType) -> Bool {
        switch self {
        case let .fiveVictoryWithOtherFace(face):
            switch face {
            case .gold:
                switch otherFace {
                case .gold: return true
                case let .selectAll(types):
                    for type in types {
                        switch type {
                        case .gold: return true
                        default: break
                        }
                    }
                case let .fiveVictoryWithOtherFace(face):
                    switch face {
                    case .gold: return true
                    default: return false
                    }
                default: return false
                }
            case .sunShard:
                switch otherFace {
                case .sunShard: return true
                case let .selectAll(types):
                    for type in types {
                        switch type {
                        case .sunShard: return true
                        default: break
                        }
                    }
                case let .fiveVictoryWithOtherFace(face):
                    switch face {
                    case .sunShard: return true
                    default: return false
                    }
                default: return false
                }
            case .moonShard:
                switch otherFace {
                case .moonShard: return true
                case let .selectAll(types):
                    for type in types {
                        switch type {
                        case .moonShard: return true
                        default: break
                        }
                    }
                case let .fiveVictoryWithOtherFace(face):
                    switch face {
                    case .moonShard: return true
                    default: return false
                    }
                default: return false
                }
            case .victory:
                switch otherFace {
                case .victory: return true
                case let .selectAll(types):
                    for type in types {
                        switch type {
                        case .victory: return true
                        default: break
                        }
                    }
                case let .fiveVictoryWithOtherFace(face):
                    switch face {
                    case .victory: return true
                    default: return false
                    }
                default: return false
                }
            default: fatalError("unexpected die face in 5 split")
            }
        default: fatalError("Checking only supported for 5/split face")
        }
        return false
    }
}

