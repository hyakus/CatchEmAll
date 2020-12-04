//
//  MoreInfoViewController.swift
//  CatchEmAll
//
//  Created by Bryan on 04/12/2020.
//

import UIKit

class MoreInfoViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var detailsStackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func set(poke: Pokemon?)
    {
        if(poke != nil)
        {
            updateTraits(poke: poke!)
        }
    }
    
    func updateTraits(poke: Pokemon)
    {
        if(poke.sprites.frontDefault != "")
        {
            let imageUrl = URL(string: poke.sprites.frontDefault)!

            let imageData = try! Data(contentsOf: imageUrl)

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView?.image = image
            }
        }
        
        for abilityGroup in poke.abilities
        {
            DispatchQueue.main.async {
                let alreadyAdded = self.detailsStackView?.arrangedSubviews
                    .filter({ ($0 as? AbilityView)?.ability()?.name == abilityGroup.name() }).count ?? 0 > 0
                
                if(!alreadyAdded)
                {
                    self.detailsStackView?.addArrangedSubview(abilityGroup.getView(viewController: self))
                }
            }
        }
        
//        for moveGroup in poke.moves
//        {
//            DispatchQueue.main.async {
//                let alreadyAdded = self.detailsStackView?.arrangedSubviews
//                    .filter({ ($0 as? MoveView)?.moveGroup?.move.name == moveGroup.move.name }).count ?? 0 > 0
//                
//                if(!alreadyAdded)
//                {
//                    print("moveCount \(poke.moves.count)")
//                    self.detailsStackView?.addArrangedSubview(moveGroup.getView(viewController: self))
//                }
//            }
//        }
    }
}
