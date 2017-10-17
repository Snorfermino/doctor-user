//
//  DoctorInfoCell.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 10/16/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class DoctorInfoCell: UITableViewCell {
    @IBOutlet weak var lbSkill: UILabel!
    @IBOutlet weak var lbSkillInfo: UILabel!
    @IBOutlet weak var imgViewSkill: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
