//
//  main.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 27.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

var field: Field?
var player1: PlayerClass = PlayerFactory.create(PlayerEnum.Human, figure: Figure.X)!
var player2: PlayerClass = PlayerFactory.create(PlayerEnum.ComputerMinMax, figure: Figure.O)!
var players: [PlayerClass] = [player1, player2]
var x: Int

while true {
    field = Field()
    field!.show()
    gameLoop: for i in 0...field!.getSize()-1 {
        x = players[i%2].getMove(field!)
        field!.set(x, figure: players[i%2].figure)
        field!.show()
        switch field!.getStatus(x) {
        case Status.won:
            print("\(players[i%2].figure) won\n\n")
            break gameLoop
        case Status.draw:
            print("Draw\n\n")
            break gameLoop
        default:
            break
        }
    }
}
