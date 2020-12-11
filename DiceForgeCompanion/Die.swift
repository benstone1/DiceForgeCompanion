import UIKit

struct Die {
//    let faceOne: DieFace
//    let faceTwo: DieFace
//    let faceThree: DieFace
//    let faceFour: DieFace
//    let faceFive: DieFace
//    let faceSix: DieFace
    let faces: [DieFace]
    init(faces: [DieFace]) {
        self.faces = faces
//        self.faceOne = faces[0]
//        self.faceTwo = faces[1]
//        self.faceThree = faces[2]
//        self.faceFour = faces[3]
//        self.faceFive = faces[4]
//        self.faceSix = faces[5]
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
        DieFace(image: UIImage(named: "oneSun")!, type: .sunShard(1)),
        DieFace(image: UIImage(named: "oneMoon")!, type: .moonShard(1)),
        DieFace(image: UIImage(named: "twoVictory")!, type: .victory(2)),
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
