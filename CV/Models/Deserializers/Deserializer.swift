//
//  Deserializer.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation

struct Deserializer {
    
    static let shared = Deserializer()
    
    func deserialize<Entity: Decodable>(data: Data) throws -> Entity {
        
        return try JSONDecoder().decode(Entity.self, from: data)
        
    }
    
}
