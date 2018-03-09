//
//  AreaCoordinator.swift
//  CV
//
//  Created by Paolo Carollo on 09/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

struct AreaCoordinator: Coordinator {
    
    private(set) var area: Area
    var topViewController: UIViewController {
        return self.navigationController
    }
    
    private var navigationController: UINavigationController
    private var areaDatasource: AreaDatasource
    private var rootViewController: UIViewController
    
    init(area: Area) {
        self.area = area
        self.areaDatasource = AreaDatasource(with: area)
        
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.title = area.name.capitalized
        self.navigationController.tabBarItem.image = UIImage(named: area.name.lowercased())

        let viewController = AreaViewController(datasource: areaDatasource)
        viewController.title = area.name.capitalized
        self.rootViewController = viewController
        
    }
    
    func start() {
    
        self.navigationController.setViewControllers([rootViewController], animated: false)
        
    }
    
}
