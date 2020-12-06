//
//  MoveCollectionViewCell.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoveCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var moveLabel: UILabel?
    
    var moveGroup: MoveGroup?
    var abilityGroup: AbilityGroup?
    
    func update(moveGroup: MoveGroup)
    {
        if(moveGroup.name() == self.moveGroup?.name())
        {
            return
        }
        
        self.moveGroup = moveGroup
        updateLabel(string: moveGroup.name())
    }
    
    func update(abilityGroup: AbilityGroup)
    {
        if(abilityGroup.name() == self.abilityGroup?.name())
        {
            return
        }
        
        self.abilityGroup = abilityGroup
        updateLabel(string: abilityGroup.name())
    }
    
    func updateLabel(string: String)
    {
        DispatchQueue.main.async {
            self.moveLabel?.text = string
        }
    }
    
}

