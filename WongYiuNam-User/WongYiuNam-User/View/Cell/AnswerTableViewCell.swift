//
//  AnswerTableViewCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/9/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var symptomTypeLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func playButtonClicked(sender: Any) {
        
    }
}
