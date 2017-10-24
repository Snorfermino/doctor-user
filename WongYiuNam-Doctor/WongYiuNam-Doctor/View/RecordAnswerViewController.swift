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
import SVProgressHUD
class RecordAnswerViewController: BaseViewController {
    
    var photoImage: UIImageView!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var btnRecord:UIButton!
    @IBOutlet weak var checkBoxIsFree: WYNCheckBox!
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbPatientName:UILabel!
    @IBOutlet weak var lbCreatedDate:UILabel!
    @IBOutlet weak var lbPatientGender:UILabel!
    @IBOutlet weak var lbPatientDOB:UILabel!
    @IBOutlet weak var lbSymptom:UILabel!
    @IBOutlet weak var lbRecordDuration:UILabel!
    @IBOutlet weak var pvRecordProgress:UIProgressView!
    @IBOutlet weak var imgViewSymptomPhoto:UIImageView!
    var timer: Timer!
    var updater: CADisplayLink! = nil
    var viewModel: RecordAnswerViewModel!
    var questionInfo: WYNQuestion!
    var isRecording = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecordAnswerViewModel(self)
        checkBoxIsFree.delegate = self
        recordTemp()
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        navBar.lbTitle.text = "Answer Question"
        pvRecordProgress.setProgress(0, animated: true)
        self.lbRecordDuration.text = "00:00"
        // TODO: remove comment code
        //tvQuestion.text = questionInfo.question
        //lbPatientName.text = questionInfo.patientName
        //lbPatientGender.text = questionInfo.patientGender
        //lbPatientDOB.text = "\(questionInfo.patientDob!)"
        
        //lbCreatedDate.text = questionInfo.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        guard questionInfo != nil else { return}
        imgViewSymptomPhoto.sd_setImage(with: questionInfo.photoUrl, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)
    }
    func recordTemp(){
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.defaultToSpeaker])
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
    
    func timeStringFor(seconds : Int) -> String
    {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour]
        formatter.zeroFormattingBehavior = .pad
        let output = formatter.string(from: TimeInterval(seconds))!
        return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    }
    
    @objc func updateProgressBar(){
        let currentTime = AudioPlayerManager.shared.audioFileCurrentTime()
        let duration = AudioPlayerManager.shared.audioFileDuration()
        let normalizedTime = Float(currentTime * 100.0 / duration)
        lbRecordDuration.text = "\(timeStringFor(seconds:Int(currentTime)))"
        print("========\(normalizedTime)")
        pvRecordProgress.setProgress(normalizedTime / 100, animated: true)
        self.view.setNeedsDisplay()
    }
    
    func updateRecordProgress(){
        let currentTime = AudioPlayerManager.shared.audioFileCurrentTime()
        let duration = 12000.0
        let normalizedTime = Float(currentTime / duration)
        lbRecordDuration.text = "\(timeStringFor(seconds:Int(currentTime)))"
        print("========\(normalizedTime)")
        pvRecordProgress.setProgress(normalizedTime, animated: true)
        self.view.setNeedsDisplay()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func startRecordingTemp() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        updater.invalidate()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record(forDuration: 12000)
            isRecording = true
            self.pvRecordProgress.setProgress(0, animated: true)
            self.lbRecordDuration.text = "00:00"
            updater = CADisplayLink(target: self, selector: Selector("updateRecordProgress"))
            updater.frameInterval = 1
            updater.add(to: .current, forMode: .commonModes)
            btnRecord.setImage(#imageLiteral(resourceName: "ic_stop"), for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PatientPhotoViewController {
            viewController.photoImage = self.imgViewSymptomPhoto
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            btnRecord.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        } else {
            btnRecord.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        }
    }
    
    @IBAction func replayTapped(_ sender: UIButton){
        updater.invalidate()
        if !AudioPlayerManager.shared.isPlaying {
            let path = AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording")
            AudioPlayerManager.shared.play(path:path)
            //        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
            pvRecordProgress.setProgress(0, animated: true)
            updater = CADisplayLink(target: self, selector: Selector("updateProgressBar"))
            updater.frameInterval = 1
            updater.add(to: .current, forMode: .commonModes)
        } else {
            AudioPlayerManager.shared.pause()
            updater.invalidate()
        }
    }
    
    
    @IBAction func recordTapped(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecordingTemp()
        } else {
            finishRecording(success: true)
            replayTapped(sender)
        }
    }
    @IBAction func cancelTapped(_ sender: UIButton) {
        backPressed()
    }
    
    @IBAction func btnSubmitPressed(_ sender: UIButton){
        updater.invalidate()
        let url = URL(fileURLWithPath: AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording"))
        var parameter = WYNAnswerQuestion()
        parameter?.questionID = questionInfo.id
        parameter?.audio = url
        parameter?.duration = 2
        parameter?.isFree = checkBoxIsFree.isSelected
        SVProgressHUD.show()
        viewModel.replyQuestion(parameter!)
    }
    
    @IBAction func freeForUserTapped(_ sender: UIButton){
        checkBoxIsFree.isSelected = !checkBoxIsFree.isSelected
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
extension RecordAnswerViewController: RecordAnswerViewModelDelegate {
    func replyQuestionSuccess(){
        SVProgressHUD.dismiss()
        alert(title: "Success", message: "Answer has been submitted")
    }
    func replyQuestionFailed(){
        SVProgressHUD.dismiss()
        alert(title: "Error", message: "Failed to submit answer")
    }
}
extension RecordAnswerViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }
}
