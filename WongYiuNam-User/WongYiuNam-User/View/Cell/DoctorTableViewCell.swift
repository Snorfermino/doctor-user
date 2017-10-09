//
//  DoctorTableViewCell.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(doctor: Doctor) {
        //avatarImageView.sd_setImage(with: doctor.avatar, completed: nil)
        if(doctor.online == false) {
            statusView.backgroundColor = UIColor.red
        }
        nameLabel.text = doctor.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
