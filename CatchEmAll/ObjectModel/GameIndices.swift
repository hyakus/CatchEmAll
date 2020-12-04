//
//  GameIndices.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

class GameIndices: Codable
{
    var gameIndex: Int
    var version: PokeBase
    
    private enum CodingKeys : String, CodingKey {
        case gameIndex = "game_index", version
    }
    
}
