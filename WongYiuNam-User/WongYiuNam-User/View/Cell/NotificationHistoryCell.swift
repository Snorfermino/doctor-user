//
//  NotificationHistoryCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class NotificationHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbCreatedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
