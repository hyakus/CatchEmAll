//
//  PokeCollectionViewCell.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import UIKit

class PokecollectionViewCell: UICollectionViewCell, PokePIDelegate
{
    @IBOutlet weak var mainContentView: UIView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var detailsStackView: UIStackView?
    
    var base: PokeBase?
    var poke: Pokemon?
    var requestHandler: PokePIRequestHandler?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    public func update(base: PokeBase)
    {
        if(base.name == self.base?.name)
        {
            return
        }
        self.base = base
        
        nameLabel?.text = base.name.uppercased()
        
        DispatchQueue.main.async {
            self.mainContentView?.layer.cornerRadius = 7
        }
        
        requestHandler = PokePIRequestHandler(delegate: self)
        requestHandler?.makeRequest(url: base.url)
        
    }
    
    func requestSuccess(response: Data,
                        requestType: PokePIRequestHandler.RequestType)
    {
        switch requestType {
        case .url:
            handleURL(response: response)
            break
        default:
            break
        }
    }
    
    func requestFailed() {
        
    }
    
    func handleURL(response: Data)
    {
        do {
            let decoder = JSONDecoder()
            let poke = try decoder.decode(Pokemon.self,
                                             from: response)
            self.poke = poke
        
            self.updateTraits(poke: poke)
            
            print("success")
        }
        catch let error as NSError
        {
            print("error \(error.localizedDescription)")
            requestFailed()
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
        
        DispatchQueue.main.async {
            let alreadyAdded = self.detailsStackView?.arrangedSubviews
                .filter({ ($0 as? DimView) != nil })
                    
            if(alreadyAdded?.count == 0)
            {
                self.addDimensionsView(poke: poke)
            }
            else
            {
                let dimView = alreadyAdded?[0] as? DimView
                dimView?.update(height: poke.height, weight: poke.weight)
            }
        }
    }
    
    func addDimensionsView(poke: Pokemon)
    {
        let dimView = (Bundle.main.loadNibNamed("DimView",
                                                    owner: self,
                                                    options: nil)![0] as? DimView)!
        
        detailsStackView?.addArrangedSubview(dimView)
        
        dimView.update(height: poke.height, weight: poke.weight)
    }
    
}
