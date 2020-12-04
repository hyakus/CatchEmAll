//
//  MoveGroup.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import Foundation

class MoveGroup: Codable {
    
    var move: PokeBase
    var versionGroupDetails: [VersionGroupDetails]
    
    private enum CodingKeys : String, CodingKey {
        case move, versionGroupDetails = "version_group_details"
    }
    
    
}
