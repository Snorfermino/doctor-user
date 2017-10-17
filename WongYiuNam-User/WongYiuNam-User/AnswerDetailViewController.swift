//
//  AnswerDetailViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/28/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class AnswerDetailViewController: BaseViewController {
    @IBOutlet weak var lbQuestionStatus:UILabel!
    @IBOutlet weak var lbByDoctor:UILabel!
    @IBOutlet weak var lbPatientDetails:UILabel!
    @IBOutlet weak var lbSymptom:UILabel!
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var lbQuestionCreatedDate:UILabel!
    @IBOutlet weak var lbAnswerCreatedDate:UILabel!
    @IBOutlet weak var imgViewDoctorAvatar:UIImageView!
    
    @IBOutlet weak var lbDoctorName:UILabel!
    @IBOutlet weak var btnListenToAnswer:UIButton!
    
    var answerDetailsData: WYNAnswerHistory.WYNData!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        guard answerDetailsData != nil else {return}
        lbQuestionStatus.text = (answerDetailsData.question?.status)! ? "Answered" : "Waiting for Answer"
        lbByDoctor.text = "\(answerDetailsData.question?.patientName), \(answerDetailsData.question?.patientGender), 18"
        lbSymptom.text = answerDetailsData.question?.symptomType
        tvQuestion.text = answerDetailsData.question?.question
        
        var date = Date(timeIntervalSince1970: Double((answerDetailsData.question?.createdAt)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm MMMM dd yyyy"
        lbQuestionCreatedDate.text = dateFormatter.string(from: date)
        
        date = Date(timeIntervalSince1970: Double((answerDetailsData.createdAt)!))
        lbAnswerCreatedDate.text = dateFormatter.string(from: date)
        
    }
}
