//
//  MyCellInfo.swift
//  TestApp
//
//  Created by Gurpreet Singh on 01/11/18.
//  Copyright © 2018 Gurpreet. All rights reserved.
//

import UIKit

class MyCellInfo: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
