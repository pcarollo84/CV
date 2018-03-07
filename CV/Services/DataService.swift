//
//  DataService.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import CocoaLumberjack

protocol DataServiceProtocol {
    
    var baseURL: URL { get }
    
    init(baseURL: URL)
    
    func areas(with name: String, completion: @escaping ([Area], Error?) -> ())
    
}

struct DataService: DataServiceProtocol {
    
    enum Error: Swift.Error {
        case missingJSON
        case invalidJSON
    }
    
    private(set) var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func areas(with name: String, completion: @escaping ([Area], Swift.Error?) -> ())  {
        
        let request = URLRequest(url: baseURL.appendingPathComponent(name))
        let session = URLSession()
        
        session.dataTask(with: request) { (data, response, error) in
        
            guard let data = data else {
                completion([], Error.missingJSON)
                return
            }
            
            do {
                
                let root = try JSONDecoder().decode(Root.self, from: data)
                completion(root.areas, nil)
                
            } catch {
                
                if let json = String(data: data, encoding: .utf8) {
                    DDLogError("Error on decoding json: \(json)")
                } else {
                    DDLogError("Data is corrupted")
                }
                
                completion([], Error.invalidJSON)
                return
                
            }
            
        }
        
    }
    
}
