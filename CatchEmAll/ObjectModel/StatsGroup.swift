//
//  Stat.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import Foundation

class StatsGroup: Codable
{
    var baseStat: Int
    var effort: Int
    var stat: PokeBase
    
    private enum CodingKeys : String, CodingKey {
        case baseStat = "base_stat", effort, stat
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        baseStat = try container.decode(Int.self, forKey: .baseStat)
        effort = try container.decode(Int.self, forKey: .effort)
        
        stat = try container.decode(PokeBase.self, forKey: .stat)
    }
}
