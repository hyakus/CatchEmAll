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
    
    
    // Set the pokemon details for this cell //
    public func update(base: PokeBase)
    {
        // No need to reload this cell if it's being set to the same pokemon that it already is
        if(base.name == self.base?.name)
        {
            return
        }
        
        self.imageView?.image = UIImage(named: "no-image")
        self.base = base
        
        nameLabel?.text = base.name.uppercased()
        
        requestHandler = PokePIRequestHandler(delegate: self)
        requestHandler?.makeRequest(url: base.url,
                                    requestType: .url)
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
        if(response.count > 0)
        {
            do {
                let decoder = JSONDecoder()
                let poke = try decoder.decode(Pokemon.self,
                                                 from: response)
                self.poke = poke
            
                try self.updateTraits(poke: poke)
            }
            catch let error as NSError
            {
                print("error \(error.localizedDescription)")
                requestFailed()
            }
        }
    }
    
    func updateTraits(poke: Pokemon) throws
    {
        try prepImageView(poke: poke)
        DispatchQueue.main.async {
            self.prepDimView(poke: poke)
        }
    }
    
    func prepImageView(poke: Pokemon) throws
    {
        if(poke.sprites.frontDefault != "")
        {
            let imageUrl = URL(string: poke.sprites.frontDefault)!

            let imageData = try Data(contentsOf: imageUrl)

            let image = UIImage(data: imageData)?.resizableImage(withCapInsets: UIEdgeInsets.zero,
                                                                 resizingMode: .stretch)
            
            DispatchQueue.main.async {
                self.imageView?.image = image
            }
        }
    }
    
    func prepDimView(poke: Pokemon)
    {
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
    
    func addDimensionsView(poke: Pokemon)
    {
        let dimView = (Bundle.main.loadNibNamed("DimView",
                                                    owner: self,
                                                    options: nil)![0] as? DimView)!
        
        detailsStackView?.addArrangedSubview(dimView)
        
        dimView.update(height: poke.height, weight: poke.weight)
    }
    
}
