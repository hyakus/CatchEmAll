//
//  PokePIRequestHandler.swift
//  CatchEmAll
//
//  Created by Bryan on 03/12/2020.
//

import Foundation

protocol PokePIDelegate: AnyObject
{
    func requestSuccess(response: Data,
                        requestType: PokePIRequestHandler.RequestType)
    func requestFailed()
}

class PokePIRequestHandler: NSObject
{
    private static let listURL = "https://pokeapi.co/api/v2/pokemon/"
    private static let kQueue = "queue"
    weak open var delegate: PokePIDelegate?
    
    let apiQueue = DispatchQueue(label: PokePIRequestHandler.kQueue,
                                  qos: DispatchQoS(qosClass: .userInteractive, relativePriority: 0))
    
    public enum RequestType
    {
        case fullList
        case url
        case none
    }
    
    public init(delegate: PokePIDelegate?)
    {
        self.delegate = delegate
    }
    
    var requestType: RequestType = .none
    
    // request list of Pokemon from basic 20 Pokemon list(currently)
    func requestMainList()
    {
        self.makeRequest(url: PokePIRequestHandler.listURL,
                         requestType: .fullList)
    }
    
    func makeRequest(url: String,
                     requestType: RequestType)
    {
        
        apiQueue.async {
            self.performRequest(url: url,
                        requestType: requestType)
        }
    }
    
    private func performRequest(url: String,
                     requestType: RequestType)
    {
        self.requestType = requestType
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
                print("response status \(httpStatus.statusCode)")
                if httpStatus.statusCode == 200
                {
                    let res = String(bytes: data, encoding: .utf8)
                    print("response as string \(res ?? "nil") \(self.delegate)")
                    
                    if(res != nil)
                    {
                        self.delegate?.requestSuccess(response: data,
                                                      requestType: self.requestType)
                    }
                }
            }
            
            self.requestType = .none
        }
        task.resume()
        
    }
    
}
