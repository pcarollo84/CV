//
//  RowTableViewCell.swift
//  CV
//
//  Created by Paolo Carollo on 07/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit

class RowTableViewCell: UITableViewCell {
    
    static let ReuseIdentifier = "rowTableViewCellIdentifier"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

}
