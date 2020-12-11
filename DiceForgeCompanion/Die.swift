import Foundation

struct Die {
    let faceOne: DieFace
    let faceTwo: DieFace
    let faceThree: DieFace
    let faceFour: DieFace
    let faceFive: DieFace
    let faceSix: DieFace
    init(faces: [DieFace]) {
        self.faceOne = faces[0]
        self.faceTwo = faces[1]
        self.faceThree = faces[2]
        self.faceFour = faces[3]
        self.faceFive = faces[4]
        self.faceSix = faces[5]
    }
}

struct DieFace {
    let url: String = ""
    let type: DieFaceType
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
