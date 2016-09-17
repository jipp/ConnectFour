//
//  PlayerFactory.swift
//  ConnectFour
//
//  Created by Wolfgang Keller on 28.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class PlayerFactory {
    class func create(_ playerEnum: PlayerEnum, figure: Figure) -> PlayerClass? {
        switch playerEnum {
        case .human: return Human(figure: figure)
        case .computerRandom: return ComputerRandom(figure: figure)
        case .computerMinMax: return ComputerMinMax(figure: figure)
        default: print("\n> Player not existing\n"); return nil
        }
    }
}
