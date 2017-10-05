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
        
        viewModel = RecordAnswerViewModel(self)
        checkBoxIsFree.delegate = self
        recordTemp()
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        navBar.rightNavBar = .none
        navBar.leftNavBar = .back
        //tvQuestion.text = questionInfo.question
        //lbPatientName.text = questionInfo.patientName
        //lbPatientGender.text = questionInfo.patientGender
        //lbPatientDOB.text = "\(questionInfo.patientDob!)"
        
        //lbCreatedDate.text = questionInfo.createdAt?.format(with: "HH:mm MMMM dd yyyy")
        imgViewSymptomPhoto.sd_setImage(with: questionInfo.photoUrl, placeholderImage: #imageLiteral(resourceName: "ic_logo"), options: [.retryFailed], completed: nil)
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imgViewSymptomPhoto.addGestureRecognizer(tapGest)
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
    
    func imageTapped(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "PatientPhotoVC", sender: nil)
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
            btnRecord.setTitle("Re-Record answer", for: .normal)
        } else {
            btnRecord.setTitle("Record answer", for: .normal)
        }
    }
    
    @IBAction func replayTapped(_ sender: UIButton){
        let path = AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording")
        AudioPlayerManager.shared.play(path:path)
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
        SVProgressHUD.show()
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
