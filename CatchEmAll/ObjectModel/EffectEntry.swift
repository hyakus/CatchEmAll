//
//  MoveEffectEntries.swift
//  CatchEmAll
//
//  Created by Bryan on 06/12/2020.
//

import Foundation

class EffectEntry: Codable
{
    var effect: String
    var language: PokeBase
    var shortEffect: String
    
    private enum CodingKeys : String, CodingKey {
        case effect, language, shortEffect = "short_effect"
    }
}
