//
//  main.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 27.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

var field: Field?
var player1: PlayerClass = PlayerFactory.create(PlayerEnum.human, figure: Figure.x)!
var player2: PlayerClass = PlayerFactory.create(PlayerEnum.computerMinMax, figure: Figure.o)!
var players: [PlayerClass] = [player1, player2]
var x: Int
var y: Int

while true {
    field = Field()
    field!.show()
    gameLoop: for i in 0..<field!.getSize() {
        x = players[i%2].getMove(field!)
        y = field!.set(x, figure: players[i%2].figure)
        field!.show()
        switch field!.getStatus(x, y: y) {
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
