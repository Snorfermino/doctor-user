//
//  PendingQuestion.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import IBAnimatable
class PendingQuestion: UITableViewCell {

    @IBOutlet weak var lbQuestion:UILabel!
    @IBOutlet weak var lbCreatedAt:UILabel!
    @IBOutlet weak var lbPatientName:UILabel!
    @IBOutlet weak var lbPatientGender:UILabel!
    @IBOutlet weak var lbPatientDOB:UILabel!
    @IBOutlet weak var imgViewAvatar:AnimatableImageView!
    @IBOutlet weak var imgViewPatientSubmit:UIImageView!
    
    override func awakeFromNib() {
        
    }
}
