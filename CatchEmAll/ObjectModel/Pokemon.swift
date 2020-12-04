//
//  Pokemon.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//



import Foundation

class Pokemon: Codable
{
    var abilities: [AbilityGroup]
    var baseExperience: Int
    var forms: [PokeBase]
    var gameIndices: [GameIndices]
    var height: Int
    var heldItems: [HeldItem]
    var id: Int
    var isDefault: Bool
    var locationAreaEncountersURL: String
    var moves: [MoveGroup]
    var name: String
    var order: Int
    var species: PokeBase
    var sprites: Sprite
    var statsGroup: [StatsGroup]
    var typeGroup: [TypeGroup]
    var weight: Int
    
    private enum CodingKeys : String, CodingKey {
        case abilities, baseExperience = "base_experience", forms, gameIndices = "game_indices",height, heldItems = "held_items", id, isDefault = "is_default",locationAreaEncountersURL = "location_area_encounters",moves, name, order,species,sprites, statsGroup = "stats",typeGroup = "types", weight
    }
    
    
    
}
