//
//  AnswerHistoryCell.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AnswerHistoryCell: UITableViewCell {
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lbPatientName: UILabel!
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