//
//  VersionGroupDetails.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import Foundation

class VersionGroupDetails: Codable
{
    var levelLearnedAt: Int
    var moveLearnMethod: PokeBase
    var versionGroup: PokeBase
    
    private enum CodingKeys : String, CodingKey {
        case levelLearnedAt = "level_learned_at", moveLearnMethod = "move_learn_method", versionGroup = "version_group"
    }
    
}
