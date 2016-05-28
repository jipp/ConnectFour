//
//  Field.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 27.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Field {
    var content: [[Figure]]
    var x: Int
    var y: Int
    
    init() {
        self.x = 6
        self.y = 7
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

    func getColummns() -> Int {
        return x
    }

    func getSize() -> Int {
        return x*y
    }
    
    func show() {
        for i in 0...self.x-1 {
            for j in 0...self.y-1 {
                if (j <= self.y - 1) {
                    print("|", terminator:"")
                }
                switch content[i][j] {
                case .X:
                    print(Figure.X, terminator:"")
                case .O:
                    print(Figure.O, terminator:"")
                default:
                    print(" ", terminator:"")
                }
            }
            print("|")
            for _ in 0...self.y-1 {
                print("--", terminator:"")
            }
            print("-")
        }
    }
    
    func allowedMove(x: Int) -> Bool {
        return false
    }
    
    func getStatus() -> Status {
        if won() {
            return Status.won
        }
        if draw() {
            return Status.draw
        }
        return Status.ongoing
    }
    
    func set(x: Int, figure: Figure) {
    }
    
    func draw() -> Bool {
        for i in 0...self.x-1 {
            for j in 0...self.y-1 {
                if (content[i][j] == Figure.empty) {
                    return false
                }
            }
        }
        return true
    }
    
    func won() -> Bool {
        return false
    }
}