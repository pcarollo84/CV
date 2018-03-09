//
//  ImageTableViewCell.swift
//  CV
//
//  Created by Paolo Carollo on 09/03/2018.
//  Copyright © 2018 Paolo Carollo. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    static let ReuseIdentifier = "ImageTableViewCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
