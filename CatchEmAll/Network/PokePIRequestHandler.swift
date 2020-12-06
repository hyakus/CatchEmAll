//
//  PokePIRequestHandler.swift
//  CatchEmAll
//
//  Created by Bryan on 03/12/2020.
//

import Foundation

protocol PokePIDelegate {
    func requestSuccess(response: Data, requestType: PokePIRequestHandler.RequestType)
    func requestFailed()
}

class PokePIRequestHandler: NSObject
{
    private static let listURL = "https://pokeapi.co/api/v2/pokemon/"
    
    // This enum can be used to both pair the responses with what request
    // it relates to, and also can be used to build the URLs for the requests
    public enum RequestType
    {
        case fullList
        case url
        case none
    }
    
    private override init()
    {
        
    }
    
    init(delegate: PokePIDelegate?)
    {
        self.delegate = delegate
    }
    
    var requestType: RequestType = .none
    var delegate: PokePIDelegate?
    
    func requestMainList()
    {
        makeRequest(requestType: .fullList)
    }
    
    // Request is of a URL type
    func makeRequest(url: String)
    {
        self.requestType = .url
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
            // Connection error
                print("connection Error")
                self.delegate?.requestFailed()
                self.requestType = .none
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                print("res a \(httpStatus.statusCode)")
                if httpStatus.statusCode == 200
                {
                    // TODO: Parse JSON using object model
                    let res = String(bytes: data, encoding: .utf8)
                    print("res \(res ?? "nill")")
                    
                    if(res != nil)
                    {
                        self.delegate?.requestSuccess(response: data,
                                                      requestType: self.requestType)
                    }
//                    let responseJSON: NSDictionary = try JSONSerialization.jsonObject(with: data,
//                                                                                      options: .allowFragments) as! NSDictionary
                }
            }
            
            self.requestType = .none
        }
        task.resume()
        
    }
    
    // request list of Pokemon from basic 20 Pokemon list(currently)
    func makeRequest(requestType: RequestType)
    {
        let url = URL(string: PokePIRequestHandler.listURL)
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
            // Connection error
                print("connection Error")
                self.requestType = .none
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                print("res a \(httpStatus.statusCode)")
                if httpStatus.statusCode == 200
                {
                    // TODO: Parse JSON using object model
                    let res = String(bytes: data, encoding: .utf8)
                    print("res \(res ?? "nill")")
                    
                    if(res != nil)
                    {
                        self.delegate?.requestSuccess(response: data,
                                                      requestType: requestType)
                    }
//                    let responseJSON: NSDictionary = try JSONSerialization.jsonObject(with: data,
//                                                                                      options: .allowFragments) as! NSDictionary
                }
            }
            
            self.requestType = .none
        }
        task.resume()
    }
    
    
    
}