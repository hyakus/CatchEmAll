//
//  MoveDetails.swift
//  CatchEmAll
//
//  Created by Bryan on 06/12/2020.
//

import Foundation

class MoveDetails: Codable
{
    private var name: String
    var effectEntries: [EffectEntry]
    var type: PokeBase
    
    private enum CodingKeys : String, CodingKey {
        case name, effectEntries = "effect_entries", type
    }
    
    public func nameFormat() -> String
    {
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
    
    public func effectEntry(for language: String) -> EffectEntry?
    {
        if(effectEntries.contains(where: {$0.language.name == language}))
        {
            return effectEntries.first(where: {$0.language.name == language})
        }
        return nil
    }
}
