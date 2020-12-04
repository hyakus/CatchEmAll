//
//  Sprite.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

class Sprite: Codable
{
    var backDefault: String
    var frontDefault: String

    
    private enum CodingKeys : String, CodingKey {
        case backDefault = "back_default", frontDefault = "front_default"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        frontDefault = try container.decode(String.self, forKey: .frontDefault)
        backDefault = try container.decode(String.self, forKey: .backDefault)
    }
}
