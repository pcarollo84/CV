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

struct AppCoordinator: Coordinator {
    
    private(set) var window: UIWindow?
    private(set) var tabBarController: UITabBarController
    
    private var dataService: DataService
    
    init(in window: UIWindow?) {
        
        self.window = window
        self.tabBarController = UITabBarController()
        
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
            
            DispatchQueue.main.async {

                self.setup(tabBarController: self.tabBarController, areas: areas)

            }
            
        }
        
    }
    
    func setup(tabBarController: UITabBarController, areas: [Area]) {

        var viewControllers: [UIViewController] = []
        
        for area in areas {
            
            let viewController = UIViewController()
            viewController.title = area.name
            
            viewControllers.append(viewController)
        }
        
        tabBarController.setViewControllers(viewControllers, animated: false)
        
    }
    
}
