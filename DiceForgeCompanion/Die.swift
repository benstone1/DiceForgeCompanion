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
}
