//
//  Field.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 27.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

// |1|2|3|4|5|6|7|8|    |0,6|1,6|2,6|3,6|4,6|5,6|6,6|7,6|
// | | | | | | | | |    |   |   |   |   |   |   |   |   |
// | | | | | | | | |    |   |   |   |   |   |   |   |   |
// | | | | | | | | |    |   |   |   |   |   |   |   |   |
// | | | | | | | | |    |0,0|1,0|2,0|3,0|4,0|5,0|6,0|7,0|
// -----------------    ---------------------------------

class Field {
    var content: [[Figure]]
    var x: Int
    var y: Int
    
    init() {
        self.x = 7
        self.y = 6
        content = Array(count: self.x, repeatedValue: Array(count: self.y, repeatedValue: Figure.empty))
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        content = Array(count: self.x, repeatedValue: Array(count: self.y, repeatedValue: Figure.empty))
    }
    
    func getRows() -> Int {
        return y
    }

    func getColumns() -> Int {
        return x
    }

    func getSize() -> Int {
        return x*y
    }
    
    func show() {
        for y in 0...self.y-1 {
            for x in 0...self.x-1 {
                if (x <= self.x - 1) {
                    print("|", terminator:"")
                }
                switch content[x][self.y - y - 1] {
                case .X:
                    print(Figure.X, terminator:"")
                case .O:
                    print(Figure.O, terminator:"")
                default:
                    print(" ", terminator:"")
                }
            }
            print("|")
        }
        for _ in 0...self.x-1 {
            print("--", terminator:"")
        }
        print("-")
    }
    
    func allowedMove(x: Int) -> Bool {
        if (x >= 0) && (x < self.x) {
            if content[x][self.y - 1] == Figure.empty {
                return true
            }
        }
        return false
    }
    
    func set(x: Int, figure: Figure) -> Int{
        var y: Int = 0
        
        for i in 0...self.y-1 {
            if (content[x][i] == Figure.empty) {
                content[x][i] = figure
                y = i
                break
            }
        }
        return y
    }
    
    func remove(x: Int) {
        var y: Int = 0
        
        for i in 0...self.y-1 {
            if (content[x][i] != Figure.empty) {
                y = i
            } else {
                break
            }
        }
        remove(x, y: y)
    }
    
    func remove(x: Int, y: Int) {
        content[x][y] = Figure.empty
    }

    func getStatus(x: Int, y: Int) -> Status {
        if won(x, y: y) {
            return Status.won
        }
        if draw() {
            return Status.draw
        }
        return Status.ongoing
    }
    
    func draw() -> Bool {
        for i in 0...self.x-1 {
                if (content[i][self.y-1] == Figure.empty) {
                    return false
                }
        }
        return true
    }
    
/*    func getPosition(x: Int) -> Int {
        var y: Int = 0
        
        for i in 0...(self.y-1) {
            if content[x][self.y - i - 1] != Figure.empty {
                y = self.y - i - 1
                break
            }
        }
        return y
    }*/
    
    func checkHorizontal(x: Int, y: Int) -> Bool {
        var sum: Int = 0

        for i in -3...0 {
            for j in 0...3 {
                if (x+i+j>=0 && x+i+j<self.x) {
                    sum += content[x+i+j][y].rawValue
                }
            }
            if (abs(sum) == 4) {
                return true
            }
            sum = 0
        }
        
        return false
    }
    
    func checkVertical(x: Int, y: Int) -> Bool {
        var sum: Int = 0

        for i in -3...0 {
            for j in 0...3 {
                if (y+i+j>=0 && y+i+j<self.y) {
                    sum += content[x][y+i+j].rawValue
                }
            }
            if (abs(sum) == 4) {
                return true
            }
            sum = 0
        }
        return false
    }
    
    func checkSlash(x: Int, y: Int) -> Bool {
        var sum: Int = 0
        
        for i in -3...0 {
            for j in 0...3 {
                if (y+i+j>=0 && y+i+j<self.y) {
                    if (x+i+j>=0 && x+i+j<self.x) {
                        sum += content[x+i+j][y+i+j].rawValue
                    }
                }
            }
            if (abs(sum) == 4) {
                return true
            }
            sum = 0
        }
        return false
    }

    func checkBackSlash(x: Int, y: Int) -> Bool {
        var sum: Int = 0
        
        for i in -3...0 {
            for j in 0...3 {
                if (y+i-j>=0 && y+i-j<self.y) {
                    if (x+i+j>=0 && x+i+j<self.x) {
                        sum += content[x+i+j][y+i-j].rawValue
                    }
                }
            }
            if (abs(sum) == 4) {
                return true
            }
            sum = 0
        }
        return false
    }

    func won(x: Int) -> Bool {
        var y: Int = 0
        
        for i in 0...self.y-1 {
            if content[x][self.y - 1 - i] != Figure.empty {
                y = self.y - 1 - i
                break
            }
        }
        
        return won(x, y: y)
    }
    
    func won(x: Int, y: Int) -> Bool {
        if (checkHorizontal(x, y: y)) {
            return true
        }
        
        if (checkVertical(x, y: y)) {
            return true
        }
        
        if (checkSlash(x, y: y)) {
            return true
        }

        if (checkBackSlash(x, y: y)) {
            return true
        }

        return false
    }
}
