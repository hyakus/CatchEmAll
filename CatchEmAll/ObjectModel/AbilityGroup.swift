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
        return ability.name
    }
    
    public func getView(viewController: UIViewController) -> AbilityView
    {
        let abilityView = (Bundle.main.loadNibNamed("AbilityView",
                                                    owner: viewController,
                                                    options: nil)![0] as? AbilityView)!
        
        abilityView.update(abilityGroup: self)
        return abilityView
    }
}
