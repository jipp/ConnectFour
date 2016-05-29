//
//  PlayerFactory.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 28.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class PlayerFactory {
    class func create(playerEnum: PlayerEnum, figure: Figure) -> PlayerClass? {
        switch playerEnum {
        case .Human: return Human(figure: figure)
        case .ComputerRandom: return ComputerRandom(figure: figure)
        default: print("\n> Player not existing\n"); return nil
        }
    }
}