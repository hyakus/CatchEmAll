//
//  TypeGroup.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

class TypeGroup: Codable
{
    var slot: Int
    var type: PokeBase
    
    
    private enum CodingKeys : String, CodingKey {
        case slot, type
    }
}
