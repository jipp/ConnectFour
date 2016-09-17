//
//  ComputerRandom.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 29.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class ComputerRandom: PlayerClass {
    override func getMove(field: Field) -> Int {
        print("\(figure) turn")
        repeat {
            x = Int(arc4random_uniform(UInt32(field.getColumns())))
        } while !field.allowedMove(x: x)
        return x
    }
}
