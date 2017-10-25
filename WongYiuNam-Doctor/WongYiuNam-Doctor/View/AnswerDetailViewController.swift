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
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
     var player:AVAudioPlayer!
    var answerDetailsData: WYNAnswerHistory.WYNData!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "AnswerHistoryCell", bundle: nil), forCellReuseIdentifier: "AnswerDetail")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
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
        lbPatientDetails.text = "\((answerDetailsData.question?.patientName)!), \((answerDetailsData.question?.patientGender)!), \(age)"
        lbSymptom.text = answerDetailsData.question?.symptomType
        lbByDoctor.text = answerDetailsData.doctor?.name
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
        downloadFileFromURL(url: url!)
    }
}
extension AnswerDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerDetail") as! AnswerHistoryCell
        guard answerDetailsData != nil else {
            return cell
        }
        cell.cellData = answerDetailsData
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
