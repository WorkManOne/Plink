//
//  GameModel.swift
//  plink
//
//  Created by Кирилл Архипов on 10.05.2024.
//

import Foundation

enum directions {
    case left, right, up, down
}

struct Block : Equatable {
    var name : String
}

class GameModel : ObservableObject {
    @Published var size : Int
    @Published var steps : Int
    @Published var field : [[Block]]
    @Published var isDone : Bool
    private var doneField : [Block]
    init() {
        self.steps = 0
        self.size = 4
        self.field = []
        self.doneField = []
        self.isDone = false
        for i in 0..<size {
            var row : [Block] = []
            for j in 0..<size {
                row.append(Block(name: String(i*size + j)))
                doneField.append(Block(name: String(i*size + j)))
            }
            self.field.append(row)
        }
        doneField.removeFirst()
        self.shuffle()
    }
    
    func shuffle() {
        var pyat = [Int]()
        for i in 0..<size*size {
            pyat.append(i)
        }
        
        for i in 0..<size {
            for j in 0..<size {
                let position = Int.random(in: 0..<pyat.count)
                let number = pyat[position]
                pyat.remove(at: position)
                field[i][j] = Block(name: String(number))
            }
        }
    }
    
    func checkIsDone() {
        var newField = [Block]()
        for i in 0..<size {
            for j in 0..<size {
                newField.append(field[i][j])
            }
        }
        if let index = newField.firstIndex(of: Block(name: "0")) {
            newField.remove(at: index)
            isDone = newField == doneField
        }
    }
    
    func moveTo(direction: directions, position: (Int, Int)) -> Bool {
        var newPosition = position
        switch direction {
        case .up:
            newPosition.0 = newPosition.0 - 1
        case .down:
            newPosition.0 = newPosition.0 + 1
        case .left:
            newPosition.1 = newPosition.1 - 1
        case .right:
            newPosition.1 = newPosition.1 + 1
        }
        if !(newPosition.0 < 0 || newPosition.0 > size-1 || newPosition.1 < 0 || newPosition.1 > size-1) {
            if self.field[newPosition.0][newPosition.1].name == "0" {
                print("\(field[position.0][position.1]) -> \(field[newPosition.0][newPosition.1]):\(position) -> \(newPosition)")

                let temp = field[position.0][position.1]
                field[position.0][position.1] = field[newPosition.0][newPosition.1]
                field[newPosition.0][newPosition.1] = temp
                steps += 1
                checkIsDone()
                return true
            }
            else {
                //print("bad")
                return false
            }
        }
        else {
            return false
        }
    }
}
