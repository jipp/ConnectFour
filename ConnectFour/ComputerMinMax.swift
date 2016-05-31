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
    
    override func getMove(field: Field) -> Int {
        var x: Int = 0
        
        count = 0
        
        print("\(figure) turn")
        
        x = maximizingResult(field, depth: 7, alpha: Int.min, beta: Int.max)
        
        if debug {
            print("Count: \(count)")
        }
        
        return x
    }
    
    func maximizingResult(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = alpha
        var value: Int
        var y: Int = 0
        
        move: for i in 0...field.getColumns()-1 {
                if (field.content[i][field.getRows()-1] == Figure.empty) {
                    y = field.set(i, figure: figure)
                    value = minimizing(field, x: i, depth: depth-1, alpha: maxValue, beta: beta)
                    field.content[i][y] = Figure.empty
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
    
    
    func maximizing(field: Field, x: Int, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = Int.min
        var value: Int
        var y: Int = 0
        
        count += 1
        
        if (field.won(x)) {
            return  -1 - depth
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        move: for i in 0...field.getColumns()-1 {
            if (field.content[i][field.getRows()-1] == Figure.empty) {
                y = field.set(i, figure: figure)
                value = minimizing(field, x: i, depth: depth-1, alpha: maxValue, beta: beta)
                field.content[i][y] = Figure.empty
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
    
    func minimizing(field: Field, x: Int, depth: Int, alpha: Int, beta: Int) -> Int {
        var minValue: Int = Int.max
        var value: Int
        var y: Int = 0
        
        count += 1
        
        if (field.won(x)) {
            return 1 + depth
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        move: for i in 0...field.getColumns()-1 {
            if (field.content[i][field.getRows()-1] == Figure.empty) {
                y = field.set(i, figure: getOpponent())
                    value = maximizing(field, x: i, depth: depth-1, alpha: alpha, beta: minValue)
                field.content[i][y] = Figure.empty
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
}