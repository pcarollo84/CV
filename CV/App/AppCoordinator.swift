//
//  AppCoordinator.swift
//  CV
//
//  Created by Paolo Carollo on 04/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

struct AppCoordinator: Coordinator {
    
    private(set) var window: UIWindow?
    private(set) var tabBarController: UITabBarController
    
    init(in window: UIWindow?) {
        
        self.window = window
        self.tabBarController = UITabBarController()
        
    }
    
    func start() {
        
        setup(tabBarController: tabBarController)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
    }
    
    func setup(tabBarController: UITabBarController) {
        
        let viewController1 = UIViewController()
        viewController1.title = "title1"
        
        let viewController2 = UIViewController()
        viewController2.title = "title2"
        
        tabBarController.setViewControllers([viewController1, viewController2], animated: false)
        
    }
    
}
