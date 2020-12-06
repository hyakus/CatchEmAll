//
//  MoveGroup.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoveGroup: Codable
{
    var move: PokeBase
    var versionGroupDetails: [VersionGroupDetails]
    
    private enum CodingKeys : String, CodingKey {
        case move, versionGroupDetails = "version_group_details"
    }
    
    public func name() -> String
    {
        let name = move.name
        if(!name.contains("-"))
        {
            return name.prefix(1).capitalized + name.dropFirst()
        }
        else
        {
            let split = name.split(separator: "-")
            
            var ret = ""
            for s in split
            {
                ret.append("\(s.prefix(1).capitalized + s.dropFirst()) ")
            }
            return ret
        }
    }
    
}
