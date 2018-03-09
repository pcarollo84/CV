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
//    private(set) var tabBarController: UITabBarController
    
    private(set) var navigationController: UINavigationController
    private(set) var startViewController: StartViewController
    
    var topViewController: UIViewController {
        return self.startViewController
    }
    
    private var dataService: DataService

    init(in window: UIWindow?) {

        self.dataService = DataService(baseURL: Bundle.main.bundleURL)
        
        self.window = window
        
        self.startViewController = StartViewController()
        self.navigationController = UINavigationController(rootViewController: startViewController)

        //  Set handlers
        self.startViewController.correctButtonSelected = { [weak self] in
            
            self?.dataService.areas(with: "data.json") { (areas, error) in
                
                DispatchQueue.main.async {
                    self?.pushTabCoordinator(areas: areas)
                }
                
            }
            
        }
        
        //  Setup 3rd party Libs
        //  CocoaLumberjack
        DDLog.add(DDTTYLogger.sharedInstance) // Xcode console
        
    }
    
    func start() {

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        //  TODO: Add a UIActivityIndicator
      
        
    }

    private func pushTabCoordinator(areas: [Area]) {
        
        let tabCoordinator = TabCoordinator(with: areas)
        tabCoordinator.start()
        self.navigationController.present(tabCoordinator.topViewController, animated: true, completion: nil)
        
    }
    
}

