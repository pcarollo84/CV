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

        self.setupNavigationController()
        
        //  Setup 3rd party Libs
        //  CocoaLumberjack
        DDLog.add(DDTTYLogger.sharedInstance) // Xcode console
        
    }
    
    func start() {

        self.showNavigationViewController()
        
    }
    
    func setupNavigationController() {
        
        //  Set handlers
        self.startViewController.correctButtonSelected = { [weak self] in
            
            self?.dataService.areas(with: "data.json") { (areas, error) in
                
                guard areas.count > 0 else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.pushTabCoordinator(areas: areas)
                }
                
            }
            
        }
        
        self.startViewController.wrongButtonSelected = { [weak self] in
            
            self?.dataService.areas(with: "wrong.json", completion: { (areas, error) in
                
                guard let _ = error else {
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self?.navigationController.pushViewController(WrongViewController(), animated: true)
                    
                }
                
            })
            
        }
    }
    
    func showNavigationViewController() {
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func showStartViewController() {
        if let _ = self.navigationController.popToRootViewController(animated: false) {
            return
        }
        
        self.navigationController.dismiss(animated: false, completion: nil)
    }

    private func pushTabCoordinator(areas: [Area]) {
        
        let tabCoordinator = TabCoordinator(with: areas)
        tabCoordinator.start()
        self.navigationController.present(tabCoordinator.topViewController, animated: true, completion: nil)
        
    }
    
}

