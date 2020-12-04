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
    
    public func getView(viewController: UIViewController) -> MoveView
    {
        let moveView = (Bundle.main.loadNibNamed("MoveView",
                                                    owner: viewController,
                                                    options: nil)![0] as? MoveView)!
        
        moveView.update(moveGroup: self)
        return moveView
    }
    
}
