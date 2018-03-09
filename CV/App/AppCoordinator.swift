//
//  AppCoordinator.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

class AppCoordinator: Coordinator {
    
    private(set) var window: UIWindow?
    private(set) var tabBarController: UITabBarController
    
    var topViewController: UIViewController {
        return self.tabBarController
    }
    
    private var dataService: DataService
    private var areaCoordinators: [Coordinator] = []
    private var viewControllers: [UIViewController] {
        return areaCoordinators.flatMap({return $0.topViewController})
    }
    private var areas: [Area] = []

    init(in window: UIWindow?) {
        
        self.window = window
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.tintColor = UIColor.themeColour
        
        self.dataService = DataService(baseURL: Bundle.main.bundleURL)
        
        //  Setup 3rd party Libs
        
        //  CocoaLumberjack
        DDLog.add(DDTTYLogger.sharedInstance) // Xcode console
        
    }
    
    func start() {

        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible()
        
        //  TODO: Add a UIActivityIndicator
        
        dataService.areas(with: "data.json") { (areas, error) in
            
            self.areas = areas
            self.areaCoordinators = self.coordinators(for: areas)
            
            DispatchQueue.main.async {

                self.tabBarController.setViewControllers(self.viewControllers, animated: false)

            }
            
        }
        
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

