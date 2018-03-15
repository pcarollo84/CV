//
//  WrongViewController.swift
//  CV
//
//  Created by Paolo Carollo on 09/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit

class WrongViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    init() {
        super.init(nibName: "WrongViewController", bundle: Bundle(for: WrongViewController.classForCoder()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageLabel.text = "Don't panic! \n42 \nis \nthe \nanswer".uppercased()
        self.messageLabel.textColor = UIColor.white
        self.messageLabel.font = UIFont.systemFont(ofSize: 72)
        
        self.view.backgroundColor = UIColor.themeColour
        
    }
    
}
