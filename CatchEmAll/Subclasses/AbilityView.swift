//
//  DimView.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class AbilityView: UIView
{
    var abilityGroup: AbilityGroup?
    
    @IBOutlet weak var nameLabel: UILabel?
    
    func loadNib() -> AbilityView
    {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! AbilityView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(abilityGroup: AbilityGroup)
    {
        self.abilityGroup = abilityGroup
//        load ability
        DispatchQueue.main.async {
            self.nameLabel?.text = abilityGroup.ability.name
        }
    }
    
    func ability() -> PokeBase?
    {
        return self.abilityGroup?.ability
    }
    
}
