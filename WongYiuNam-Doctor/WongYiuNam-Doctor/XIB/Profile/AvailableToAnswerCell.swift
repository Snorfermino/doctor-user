//
//  AvailableToAnswerCell.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 10/16/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AvailableToAnswerCell: UITableViewCell {
    
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var checkbox: WYNCheckBox!
    var isAvailable: Bool = false
    {
        didSet{
            checkbox.isSelected = isAvailable
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnCheckboxPressed(_ sender: Any) {
        checkbox.isSelected = !checkbox.isSelected
        isAvailable = checkbox.isSelected
    }
    
}
