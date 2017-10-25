//
//  AnswerHistoryCell.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
protocol AnswerHistoryCellDelegate {
    func btnPlayTapped()
}
class AnswerHistoryCell: UITableViewCell {
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var lbQuestion:UILabel!
    @IBOutlet weak var imageViewDoctorProfile: UIImageView!
    @IBOutlet weak var lbPatientName: UILabel!
    @IBOutlet weak var lbCreatedAt: UILabel!
    @IBOutlet weak var lbAnsweredAt: UILabel!
    @IBOutlet weak var lbDoctorName: UILabel!
    
    var cellData:WYNAnswerHistory.WYNData! {
        didSet{
            lbQuestion.text = cellData.question?.question
            lbPatientName.text = cellData.question?.patientName
            lbDoctorName.text = cellData.doctor?.name
            lbAnsweredAt.text = cellData.doctor?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
            lbCreatedAt.text = cellData.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        }
    }
    var delegate: AnswerHistoryCellDelegate?

    @IBAction func btnPlayTapped(_ sender: UIButton){
        delegate?.btnPlayTapped()
    }
}
