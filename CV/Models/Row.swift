//
//  Row.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation

enum RowType: String, Codable {
    case description = "description"
    case image = "image"
}

protocol RowProtocol {
    
    var type: RowType { get }
    var title: String { get }
    var details: String { get }
    
}

struct Row: RowProtocol, Codable {
    
    var type: RowType
    var title: String
    var details: String
    
}
