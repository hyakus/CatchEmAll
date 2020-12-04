//
//  PokeResponse.swift
//  CatchEmAll
//
//  Created by Bryan on 03/12/2020.
//

import Foundation

// This is the base for the response request for the first 20 Pokémon ("https://pokeapi.co/api/v2/pokemon/)
class PokeResponse: Codable
{
    var count: Int
    var next: String
    var previous: String?
    var results: [PokeBase]
}
