//
//  ComputerMiniMax.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 29.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

let debug: Bool = false

class ComputerMinMax: PlayerClass {
    var count: Int = 0
    
    override func getMove(_ field: Field) -> Int {
        var x: Int = 0
        
        count = 0
        
        print("\(figure) turn")
        
        x = maximizing(field, depth: 8, alpha: Int.min, beta: Int.max)
        
        if debug {
            print("Count: \(count)")
        }
        
        return x
    }
    
    func maximizing(_ field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = alpha
        var value: Int
        var x: Int = 0
        var y: Int = 0
        
        var array = [Int](repeating: 0, count: field.getColumns())
        var shuffledArray: [Int]
        
        for i in 0..<field.getColumns() {
            array[i] = i
        }
        shuffledArray = shuffleArray(array)
        
        // move: for i in 0..<field.getColumns() {
        move: for i in shuffledArray {
            if (field.content[i][field.getRows()-1] == Figure.empty) {
                y = field.set(i, figure: figure)
                value = minimizing(field, x: i, depth: depth-1, alpha: maxValue, beta: beta)
                field.remove(i, y: y)
                if debug {
                    print(" Position: \(i, y) Value: \(value)")
                }
                if (value > maxValue) {
                    maxValue = value
                    x = i
                    if (maxValue >= beta) {
                        break move
                    }
                }
            }
        }
        
        if debug {
            print("Position: \(x) maxValue: \(maxValue)")
        }
        
        return x
    }
    
    
    func maximizing(_ field: Field, x: Int, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = Int.min
        var value: Int
        var y: Int = 0
        
        count += 1
        
        if (field.won(x)) {
            return  -1 - depth
        }
        if (field.draw() || depth <= 0) {
            return 0
        }
        
        move: for i in 0..<field.getColumns() {
            if (field.content[i][field.getRows()-1] == Figure.empty) {
                y = field.set(i, figure: figure)
                value = minimizing(field, x: i, depth: depth-1, alpha: maxValue, beta: beta)
                field.remove(i, y: y)
                if (value > maxValue) {
                    maxValue = value
                    if (maxValue >= beta) {
                        break move
                    }
                }
            }
        }
        
        return maxValue
    }
    
    func minimizing(_ field: Field, x: Int, depth: Int, alpha: Int, beta: Int) -> Int {
        var minValue: Int = Int.max
        var value: Int
        var y: Int = 0

        count += 1
        
        if (field.won(x)) {
            return 1 + depth
        }
        if (field.draw() || depth <= 0) {
            return 0
        }
        
        move: for i in 0..<field.getColumns() {
            if (field.content[i][field.getRows()-1] == Figure.empty) {
                y = field.set(i, figure: getOpponent())
                value = maximizing(field, x: i, depth: depth-1, alpha: alpha, beta: minValue)
                field.remove(i, y: y)
                if (value < minValue) {
                    minValue = value
                    if (minValue <= alpha) {
                        break move
                    }
                }
            }
        }
        
        return minValue
    }
    
    func shuffleArray<T>(_ array: Array<T>) -> Array<T> {
        var a = array
        
        for index in (1..<a.count).reversed() {
            let j = Int(arc4random_uniform(UInt32(index)))
            swap(&a[index], &a[j])
        }
        return a
    }
}
