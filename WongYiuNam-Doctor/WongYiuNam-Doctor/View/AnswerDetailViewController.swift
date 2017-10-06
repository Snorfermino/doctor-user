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
        // Do any additional setup after loading the view.
    }

    override func setupView() {
        super.setupView()
        guard answerDetailsData != nil else {return}
        if let question = answerDetailsData.question {
            lbQuestionStatus.text = question.status! ? "Answered" : "Waiting for Answer"
            lbByDoctor.text = "\(question.patientName), \(question.patientGender), 18"
            lbSymptom.text = question.symptomType
            tvQuestion.text = question.question
            lbQuestionCreatedDate.text = answerDetailsData.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        }
        
        lbAnswerCreatedDate.text = answerDetailsData.createdAt?.format(with: "HH:mm MMMM dd yyyy")
    }
}
