//
//  RequestDetailsHandler.swift
//  CatchEmAll
//
//  Created by Bryan on 06/12/2020.
//

import Foundation

protocol DetailsDelegate {
    func detailsRequestSuccess(name: String, string: String)
    func detailsRequestFailed()
}

class RequestDetailsHandler: PokePIDelegate
{
    var delegate: DetailsDelegate?
    var selection: MoreInfoViewController.Selection?

    
    func makeRequest(url: String,
                     selection: MoreInfoViewController.Selection,
                     delegate: DetailsDelegate)
    {
        self.delegate = delegate
        self.selection = selection
                    
        let api = PokePIRequestHandler(delegate: self)
        print("makeRequestDetails \(url)")
        api.makeRequest(url: url)
    }
    
    func requestSuccess(response: Data,
                        requestType: PokePIRequestHandler.RequestType)
    {
        // TODO: Load move description
        // move URL > effect entries > effect
        do {
            switch self.selection
            {
                case .moves:
                    try handleMoves(response: response)
                    break
                case .abilities:
                    try handleAbilities(response: response)
                    break
                default:
                    break
            }
        } catch let error as NSError
        {
            
        }
    }
    
    
    // Handle Move response break down //
    func handleMoves(response: Data) throws
    {
        let decoder = JSONDecoder()
        
        let moveDetails = try decoder.decode(MoveDetails.self,
                                         from: response)
        if(moveDetails.effectEntries.count > 0)
        {
            let name = moveDetails.nameFormat()
            
            let typeString = moveDetails.type.name.prefix(1).uppercased() + moveDetails.type.name.dropFirst()
            
            let effect = moveDetails.effectEntry(for: "en")?.effect
            
            if(effect != nil)
            {
                let string = "Move Type: \(typeString) \n\n\(effect!)"
                self.delegate?.detailsRequestSuccess(name: name,
                                                     string: string)
            }
        }
    }
    
    
    // Handle Ability response break down //
    func handleAbilities(response: Data) throws
    {
        let decoder = JSONDecoder()
        
        let abilityDetails = try decoder.decode(AbilityDetails.self,
                                         from: response)
        if(abilityDetails.effectEntries.count > 0)
        {
            let string = abilityDetails.effectEntry(for: "en")?.effect
            
            if(string != nil)
            {
                self.delegate?.detailsRequestSuccess(name: abilityDetails.nameFormat(),
                                                     string: string!)
            }
        }
    }
    
    func requestFailed() {
        self.delegate?.detailsRequestFailed()
    }
    
}
