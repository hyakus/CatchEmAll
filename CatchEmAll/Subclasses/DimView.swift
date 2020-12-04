//
//  DimView.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class DimView: UIView
{
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet weak var heightLabel: UILabel? // "The height of the Pokémon, in tenths of a meter (decimeters)"
    @IBOutlet weak var weightLabel: UILabel?// "The weight of the Pokémon, in tenths of a kilogram (hectograms)"
    
    func loadNib() -> DimView
    {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! DimView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(height: Int, weight: Int)
    {
        let heightMeters = height*10
        let weightKg = weight*10
        
        heightLabel?.text = "\(heightMeters) m"
        weightLabel?.text = "\(weightKg) Kg"
        
        
    }
}
