//
//  DataService.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    
    func getRoot(json: String) throws -> Root
    
}

struct DataService: DataServiceProtocol {
    
    enum Error: Swift.Error {
        case invalidJSON
    }
    
    static let shared: DataService = DataService()
    
    func getJSON() -> String {
        return ""
    }

    func getRoot(json: String) throws -> Root {
        
        guard let jsonData = json.data(using: .utf8) else {
            throw Error.invalidJSON
        }
        
        return try JSONDecoder().decode(Root.self, from: jsonData)
        
    }

    
}
