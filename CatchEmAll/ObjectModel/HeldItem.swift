//
//  HeldItem.swift
//  CatchEmAll
//
//  Created by Bryan on 03/12/2020.
//

import Foundation

class HeldItem: Codable
{
    var item: PokeBase
    var versionDetails: [VersionDetails]
    
    private enum CodingKeys : String, CodingKey {
        case item, versionDetails = "version_details"
    }
    
}
