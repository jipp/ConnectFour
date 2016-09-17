//
//  Human.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 28.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Human: PlayerClass {
    override func getMove(_ field: Field) ->  Int {
        var x: Int = -1
        var input: String
        
        print("\(figure) turn")
        repeat {
            print("Input: ", terminator:"")
            input = readLine()!
            if let row = Int(input) {
                x = row - 1
            }
        } while !field.allowedMove(x)
        return x
    }
}
