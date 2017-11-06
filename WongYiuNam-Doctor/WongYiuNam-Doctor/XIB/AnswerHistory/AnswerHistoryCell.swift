//
//  AnswerHistoryCell.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import AVFoundation
protocol AnswerHistoryCellDelegate {
    func btnPlayTapped()
}
class AnswerHistoryCell: UITableViewCell {
    @IBOutlet weak var lbListenedCount: UILabel!
    @IBOutlet weak var lbQuestion:UILabel!
    @IBOutlet weak var imageViewDoctorProfile: UIImageView!
    @IBOutlet weak var lbPatientName: UILabel!
    @IBOutlet weak var lbCreatedAt: UILabel!
    @IBOutlet weak var lbAnsweredAt: UILabel!
    @IBOutlet weak var lbDoctorName: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbSymptom: UILabel!
    @IBOutlet weak var pvRecordProgress: UIProgressView!
    var isPlaying:Bool = false
    var player:AVPlayer!
    var updater: CADisplayLink! = nil
    var cellData:WYNAnswerHistory.WYNData! {
        didSet{
            lbQuestion.text = cellData.question?.question
            lbPatientName.text = cellData.question?.patientName
            lbDoctorName.text = cellData.doctor?.name
            lbSymptom.text = cellData.question?.symptomType
            lbAnsweredAt.text = cellData.doctor?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
            lbCreatedAt.text = cellData.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
            lbListenedCount.text = "\(String(describing: cellData.viewCount!)) people have listened"
            lbDuration.text = timeStringFor(seconds: cellData.duration!)
        }
    }
    var cellDataAnswerResult: WYNRecordAnswerResult! {
        didSet{
            lbQuestion.text = cellDataAnswerResult.question?.question
            lbPatientName.text = cellDataAnswerResult.question?.patientName
            lbDoctorName.text = UserLoginInfo.shared.userInfo.name
            lbSymptom.text = cellDataAnswerResult.question?.symptomType
            lbAnsweredAt.text = cellDataAnswerResult.createdAt?.format(with: "HH:mm MMMM dd yyyy")
            lbCreatedAt.text = cellDataAnswerResult.question?.createdAt?.format(with: "HH:mm MMMM dd yyyy")
            lbListenedCount.text = "\(String(describing: cellDataAnswerResult.listentCount!)) people have listened"
            lbDuration.text = timeStringFor(seconds: cellDataAnswerResult.duration!)
        }
    }
    
    var delegate: AnswerHistoryCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        pvRecordProgress.setProgress(0, animated: true)
        self.lbDuration.text = "00:00"
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
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    @objc func updateProgressBar(){
        let currentTime = player.currentTime().seconds
        let duration = Double(cellData.duration!)
        let normalizedTime = Float(currentTime * 100.0 / duration)
        lbDuration.text = "\(timeStringFor(seconds:Int(currentTime)))"
        print("========\(normalizedTime)")
        pvRecordProgress.setProgress(normalizedTime / 100, animated: true)
        
    }
    
    @IBAction func btnPlayTapped(_ sender: UIButton){
        guard cellData != nil else { return }
        if !isPlaying {
            let url = URL(string: cellData.audioUrl!)
            play(url: url!)
            updater = CADisplayLink(target: self, selector: Selector("updateProgressBar"))
            updater.frameInterval = 1
            updater.add(to: .current, forMode: .commonModes)
        } else {
            player.pause()
            updater.invalidate()
        }
        
        //        delegate?.btnPlayTapped()
    }
    deinit {
        updater.invalidate()
    }
}
