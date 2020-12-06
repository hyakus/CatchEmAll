//
//  AbilityGroup.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import UIKit

class AbilityGroup: Codable
{
    var ability: PokeBase
    var isHidden: Bool
    var slot: Int
    
    
    private enum CodingKeys : String, CodingKey {
        case ability, isHidden = "is_hidden", slot
    }
    
    public func name() -> String
    {
        let name = ability.name
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
