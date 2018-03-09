//
//  Coordinator.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var topViewController: UIViewController { get }
    
    func start()
    
}
