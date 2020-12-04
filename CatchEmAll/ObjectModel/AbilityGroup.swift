//
//  AbilityGroup.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

class AbilityGroup: Codable
{
    var ability: PokeBase
    var isHidden: Bool
    var slot: Int
    
    
    // TODO: https://stackoverflow.com/questions/44655562/how-to-exclude-properties-from-swift-4s-codable
    //    Decode/ encode inits to include/excute keys as required
    private enum CodingKeys : String, CodingKey {
        case ability, isHidden = "is_hidden", slot
    }
    
}
