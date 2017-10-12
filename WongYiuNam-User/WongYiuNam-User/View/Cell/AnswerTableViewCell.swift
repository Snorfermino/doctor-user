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
    
    @IBAction func playButtonClicked(sender: Any) {
        
    }
    
    func setup(question: Question) {
        nameLabel.text = question.patientName
        questionLabel.text = question.question
        timeLabel.text = question.createdAt?.toString(format: "MM-dd-yyyy")
        avatarImageView.sd_setImage(with: question.photoUrl, completed: nil)
    }
}
