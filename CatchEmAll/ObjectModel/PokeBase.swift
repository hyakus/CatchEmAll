//
//  PokeBase.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

// Example: { "name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/ }
class PokeBase: Codable
{
    var name: String
    var url: String
    
    private enum CodingKeys : String, CodingKey {
        case name, url
    }
    
    
}
