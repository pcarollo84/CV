//
//  AreaDataSource.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import Foundation
import UIKit

class AreaDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private(set) var area: Area

    init(with area: Area) {
        self.area = area
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return area.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return area.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return area.sections[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = area.sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RowTableViewCell.ReuseIdentifier) as? RowTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = row.title.capitalized
        cell.detailLabel.text = row.details
        
        return cell
        
    }
    
    //  Delegate - TODO: to move
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
