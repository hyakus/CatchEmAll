//
//  DimView.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoveView: UIView
{
    var moveGroup: MoveGroup?
    
    @IBOutlet weak var nameLabel: UILabel?
    
    func loadNib() -> MoveView
    {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! MoveView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(moveGroup: MoveGroup)
    {
        self.moveGroup = moveGroup
//        load ability
        DispatchQueue.main.async {
            self.nameLabel?.text = moveGroup.move.name
        }
    }
}
