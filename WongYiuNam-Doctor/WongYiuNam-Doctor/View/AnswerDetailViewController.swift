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
import SDWebImage
class AnswerDetailViewController: BaseViewController {
    @IBOutlet weak var lbQuestionStatus:UILabel!
    @IBOutlet weak var lbByDoctor:UILabel!
    @IBOutlet weak var lbPatientDetails:UILabel!
    @IBOutlet weak var lbSymptom:UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgViewPatientPhoto: UIImageView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var patientPhotoViewHeight: NSLayoutConstraint!
    var player:AVPlayer!
    var answerDetailsData: WYNAnswerHistory.WYNData!
    var answerResult: WYNRecordAnswerResult!
    var audioURL:URL!
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
        guard answerDetailsData != nil else {
            setupViewFromRecord()
            return }
        lbQuestionStatus.text = (answerDetailsData.question?.status)!
        let now = Date()
        let birthday: Date = (answerDetailsData.question?.patientDob)!
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        lbPatientDetails.text = "\((answerDetailsData.question?.patientName)!), \((answerDetailsData.question?.patientGender)!), \(age)"
        lbSymptom.text = answerDetailsData.question?.symptomType
        lbByDoctor.text = answerDetailsData.doctor?.name
        tableView.contentOffset = CGPoint.zero
        audioURL = URL(string: answerDetailsData.audioUrl!)
        imgViewPatientPhoto.contentMode = .scaleAspectFit
        guard answerDetailsData.question?.photoUrl != nil else {
            imgViewPatientPhoto.isHidden = true
            contentViewHeight.constant -= patientPhotoViewHeight.constant
            patientPhotoViewHeight.constant = 0
            return
        }
        imgViewPatientPhoto.sd_setImage(with: answerDetailsData.question?.photoUrl!, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)
        imgViewPatientPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
    }
    
    func setupViewFromRecord(){
        guard answerResult != nil else {
            return
        }
        lbQuestionStatus.text = (answerResult.question?.status)!
        let now = Date()
        let birthday: Date = (answerResult.question?.patientDob)!
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        lbPatientDetails.text = "\((answerResult.question?.patientName)!), \((answerResult.question?.patientGender)!), \(age)"
        lbSymptom.text = answerResult.question?.symptomType
        lbByDoctor.text = UserLoginInfo.shared.userInfo.name
        tableView.contentOffset = CGPoint.zero
        audioURL = answerResult.audioUrl
        imgViewPatientPhoto.contentMode = .scaleAspectFit
        guard answerResult.question?.photoUrl != nil else {
            imgViewPatientPhoto.isHidden = true
            contentViewHeight.constant -= patientPhotoViewHeight.constant
            patientPhotoViewHeight.constant = 0
            return
        }
        imgViewPatientPhoto.sd_setImage(with: answerResult.question?.photoUrl!, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)
    }

    func timeStringFor(seconds : Int) -> String
    {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour]
        formatter.zeroFormattingBehavior = .pad
        let output = formatter.string(from: TimeInterval(seconds))!
        return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    }
    

    
    func play(url:URL) {
        print("playing \(url)")
        
        do {
            
            let playerItem = AVPlayerItem(url: url)
            
            self.player =  AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch {
            print("AVPlayer init failed")
        }
    }
    
    @objc func imageTapped(_ sender: Any){
        guard imgViewPatientPhoto.image != nil else { return }
        self.performSegue(withIdentifier: "PatientPhotoVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PatientPhotoViewController {
            if let image = imgViewPatientPhoto.image {
                viewController.photoImage = imgViewPatientPhoto
            }
        }
    }
}
extension AnswerDetailViewController: AnswerHistoryCellDelegate {
    func btnPlayTapped() {
        guard audioURL != nil else {
            alert(title: "Warning", message: "No Audio Found")
            return
            
        }
        play(url: audioURL)
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
        if answerDetailsData != nil {
                    cell.cellData = answerDetailsData
        } else {
            
        }

    
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
