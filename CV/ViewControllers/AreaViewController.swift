//
//  AreaViewController.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var datasource: UITableViewDataSource?
    
    init(datasource: UITableViewDataSource) {
        self.datasource = datasource
        super.init(nibName: "AreaViewController", bundle: Bundle(for: AreaViewController.classForCoder()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  Register cells
        tableView.register(UINib(nibName: "RowTableViewCell", bundle: Bundle(for: RowTableViewCell.classForCoder())), forCellReuseIdentifier: RowTableViewCell.ReuseIdentifier)
        tableView.dataSource = datasource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
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

}
