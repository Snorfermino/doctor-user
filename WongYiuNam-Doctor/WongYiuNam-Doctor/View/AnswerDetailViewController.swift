//
//  AnswerDetailViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/28/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import DateToolsSwift
import AVFoundation
class AnswerDetailViewController: BaseViewController {
    @IBOutlet weak var lbQuestionStatus:UILabel!
    @IBOutlet weak var lbByDoctor:UILabel!
    @IBOutlet weak var lbPatientDetails:UILabel!
    @IBOutlet weak var lbSymptom:UILabel!
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var lbQuestionCreatedDate:UILabel!
    @IBOutlet weak var lbAnswerCreatedDate:UILabel!
    @IBOutlet weak var imgViewDoctorAvatar:UIImageView!
    @IBOutlet weak var lbPatientName: UILabel!
    @IBOutlet weak var lbDoctorName:UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnListenToAnswer:UIButton!
     var player:AVAudioPlayer!
    var answerDetailsData: WYNAnswerHistory.WYNData!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerDetail")
        tableView.estimatedRowHeight = 340
        tableView.rowHeight = 340 / 667 * UIScreen.main.bounds.height
        tableView.separatorStyle = .none
        
    }
    
    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        navBar.lbTitle.text = "Answer Detail"
        setupTableView()
        guard answerDetailsData != nil else { return }
        
        lbQuestionStatus.text = (answerDetailsData.question?.status)! ? "Answered" : "Waiting for Answer"
        
        let now = Date()
        let birthday: Date = Date(timeIntervalSince1970: Double((answerDetailsData.question?.patientDob)!))
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
       
        lbPatientDetails.text = "\(answerDetailsData.question?.patientName), \(answerDetailsData.question?.patientGender), \(age)"
        lbSymptom.text = answerDetailsData.question?.symptomType
        tvQuestion.text = answerDetailsData.question?.question
        lbByDoctor.text = answerDetailsData.doctor?.name
        lbQuestionCreatedDate.text = answerDetailsData.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        
        lbAnswerCreatedDate.text = answerDetailsData.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        
        tableView.contentOffset = CGPoint.zero
    }

    func downloadFileFromURL(url:URL){
        
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (url, response, erro) in
            AudioPlayerManager.shared.play(url:url!)
            print("Download completed: URL(\(url!))")
        })
        
        downloadTask.resume()
        
    }
}
extension AnswerDetailViewController: AnswerHistoryCellDelegate {
    func btnPlayTapped() {
        guard answerDetailsData != nil else { return }
        let url = URL(string: answerDetailsData.audioUrl!)
        // TODO: remove test code
//        let url = URL(string: "https://archive.org/download/testmp3testfile/mpthreetest.mp3")
        downloadFileFromURL(url: url!)
    }
}
extension AnswerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // TODO: this function is doing nothing
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerDetail") as! AnswerHistoryCell
        guard answerDetailsData != nil else { return cell }
        // TODO: move this logic to Cell
        // TODO: when use a model multiple times, should create a var or let to store it to make the code more readable
        cell.tvQuestion.text = self.answerDetailsData.question?.question
        cell.lbPatientName.text = self.answerDetailsData.question?.patientName
        cell.lbDoctorName.text = self.answerDetailsData.doctor?.name
        cell.lbAnsweredAt.text = self.answerDetailsData.doctor?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        cell.lbCreatedAt.text = self.answerDetailsData.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        
        cell.tvQuestion.isEditable = false
        cell.tvQuestion.isScrollEnabled = false
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("soomething")
        // TODO: this function doing nothing???
//        let url = URL(string: "https://archive.org/download/testmp3testfile/mpthreetest.mp3")
//        downloadFileFromURL(url: url!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: when number of sections is 1 do not need this
        return 1
    }
}
