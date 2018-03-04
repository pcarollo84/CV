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
        case missingJSON
        case invalidJSON
    }
    
    static let shared: DataService = DataService()
    
    func getJSON(bundle: Bundle = Bundle.main) throws -> String {
        guard let url = bundle.url(forResource: "data", withExtension: "json") else {
            throw Error.missingJSON
        }
        return try String(contentsOf: url)
    }

    func getRoot(json: String) throws -> Root {
        
        guard let jsonData = json.data(using: .utf8) else {
            throw Error.invalidJSON
        }
        
        return try JSONDecoder().decode(Root.self, from: jsonData)
        
    }

    
}
