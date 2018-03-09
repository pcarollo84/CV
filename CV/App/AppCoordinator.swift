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
    
    private var dataService: DataService
    
    private var viewControllers: [UIViewController] = []
    private var datasources: [UITableViewDataSource] = []

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

            let vcsAndDs = self.viewControllersAndDataSources(areas: areas)
            self.viewControllers = vcsAndDs.viewControllers
            self.datasources = vcsAndDs.datasources
            
            DispatchQueue.main.async {

                self.tabBarController.setViewControllers(self.viewControllers, animated: false)

            }
            
        }
        
    }
    
    func viewControllersAndDataSources(areas: [Area]) -> (viewControllers: [UIViewController], datasources: [UITableViewDataSource]) {
        
        var vcs: [UIViewController] = []
        var ds: [UITableViewDataSource] = []
        
        for area in areas {
            
            let datasource = AreaDatasource(with: area)
            let viewController = AreaViewController(datasource: datasource)
            viewController.title = area.name
            
            vcs.append(viewController)
            ds.append(datasource)
        }
        
        return (vcs, ds)
    }
    
}
