//
//  Unit.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation

enum UnitType: String, Codable {
    case description = "description"
    case job = "job"
}

protocol UnitProtocol {
    
    var type: UnitType { get }
    var title: String { get }
    var details: String { get }
    
}

struct Unit: UnitProtocol, Codable {
    
    var type: UnitType
    var title: String
    var details: String
    
}
