//
//  StartViewController.swift
//  CV
//
//  Created by Paolo Carollo on 09/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!

    var correctButtonSelected: (() -> ())?
    var wrongButtonSelected: (() -> ())?
    
    init() {
        super.init(nibName: "StartViewController", bundle: Bundle(for: StartViewController.classForCoder()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `super.init(nibName: , bundle: )` instead.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func handleCorrectButtonTouchUpInside(_ sender: Any) {
        correctButtonSelected?()
    }
    
    @IBAction func handleWrongButtonTouchUpInside(_ sender: Any) {
        wrongButtonSelected?()
    }
    
    
}
