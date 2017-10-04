//
//  RecordAnswerViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage
class RecordAnswerViewController: BaseViewController {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var btnRecord:UIButton!
    @IBOutlet weak var checkBoxIsFree: WYNCheckBox!
    @IBOutlet weak var tvQuestion:UITextView!
    @IBOutlet weak var lbPatientName:UILabel!
    @IBOutlet weak var lbCreatedDate:UILabel!
    @IBOutlet weak var lbPatientGender:UILabel!
    @IBOutlet weak var lbPatientDOB:UILabel!
    @IBOutlet weak var imgViewSymptomPhoto:UIImageView!
    var viewModel: RecordAnswerViewModel!
    var questionInfo: WYNQuestion!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecordAnswerViewModel()
        checkBoxIsFree.delegate = self
        recordTemp()
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        tvQuestion.text = questionInfo.question
        lbPatientName.text = questionInfo.patientName
        lbPatientGender.text = questionInfo.patientGender
        lbPatientDOB.text = "\(questionInfo.patientDob!)"
        
        let date = Date(timeIntervalSince1970: Double(questionInfo.createdAt!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm MMMM dd yyyy"
        lbCreatedDate.text = dateFormatter.string(from: date)
        let url = URL(string: (questionInfo.photoUrl != nil) ? questionInfo.photoUrl! : "")
        imgViewSymptomPhoto.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)  
    }
    func recordTemp(){
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Record authorized")
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func startRecordingTemp() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record(forDuration: 12000)
            btnRecord.setTitle("Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            btnRecord.setTitle("Re-Record answer", for: .normal)
        } else {
            btnRecord.setTitle("Record answer", for: .normal)
            // recording failed :(
        }
    }
    
    @IBAction func recordTapped(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecordingTemp()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func btnSubmitPressed(_ sender: UIButton){
        let url = URL(fileURLWithPath: AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording"))
        var parameter = WYNAnswerQuestion()
        parameter?.questionID = questionInfo.id
        parameter?.audio = url
        parameter?.duration = 2
        parameter?.isFree = checkBoxIsFree.isSelected
        let path = AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording")
        AudioPlayerManager.shared.play(path:path)
        viewModel.replyQuestion(parameter!)
    }
}
extension RecordAnswerViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
extension RecordAnswerViewController: WYNCheckBoxDelegate{
    func WYNCheckBoxClicked(isSelected:Bool){
        if isSelected {
            //Present alert
        }
    }
}
