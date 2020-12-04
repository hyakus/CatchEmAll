//
//  PokeCollectionViewCell.swift
//  CatchEmAll
//
//  Created by Bryan on 02/12/2020.
//

import UIKit

class PokecollectionViewCell: UICollectionViewCell, PokePIDelegate
{
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    
    var base: PokeBase?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    public func update(base: PokeBase)
    {
        self.base = base
        
        nameLabel?.text = base.name
        
        imageView?.image = nil
        
        let api = PokePIRequestHandler(delegate: self)
        api.makeRequest(url: base.url)
    }
    
    func requestSuccess(response: Data, requestType: PokePIRequestHandler.RequestType)
    {
        if(requestType == .url)
        {
            do {
                let decoder = JSONDecoder()
                let poke = try decoder.decode(Pokemon.self,
                                                 from: response)
                print("success")
            }
            catch let error as NSError
            {
                print("error \(error.localizedDescription)")
                requestFailed()
            }
        }
    }
    
    func requestFailed() {
        
    }
    
}
