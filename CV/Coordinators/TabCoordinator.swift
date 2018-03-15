//
//  TabCoordinator.swift
//  CV
//
//  Created by Paolo Carollo on 09/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

class TabCoordinator: Coordinator {
    
    private(set) var tabBarController: UITabBarController
    private(set) var areas: [Area]
    
    var topViewController: UIViewController {
        return self.tabBarController
    }
    
    private var areaCoordinators: [Coordinator] = []
    private var viewControllers: [UIViewController] {
        return areaCoordinators.flatMap({return $0.topViewController})
    }
    
    init(with areas: [Area]) {

        self.areas = areas
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.tintColor = UIColor.themeColour

    }
    
    func start() {
        
        self.areaCoordinators = self.coordinators(for: areas)
        self.tabBarController.setViewControllers(self.viewControllers, animated: false)
    }
    
    func coordinators(for areas: [Area]) -> [Coordinator] {
        
        var coordinatorsArray: [Coordinator] = []
        
        for area in areas {
            
            let coordinator = AreaCoordinator(area: area)
            coordinator.start()
            coordinatorsArray.append(coordinator)
            
        }
        
        return coordinatorsArray
    }
    
}
