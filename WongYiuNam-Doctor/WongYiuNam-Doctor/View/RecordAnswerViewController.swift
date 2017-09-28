//
//  RecordAnswerViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import AVFoundation
class RecordAnswerViewController: BaseViewController {

    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var btnRecord:UIButton!
    var viewModel: RecordAnswerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecordAnswerViewModel()
        recordTemp()
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
            audioRecorder.record()
            
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
    
//    @objc func recordTapped() {
//        if audioRecorder == nil {
//            startRecordingTemp()
//        } else {
//            finishRecording(success: true)
//        }
//    }
//    var isRecording = false
//    var timerUpdater = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
//    var duration = "00.00"
//    func startRecording() {
//        isRecording = true
//        if AudioRecorderManager.shared.record("Test"){
//            timerUpdater.resume()
//        }
//
//        let dateFormatter = DateComponentsFormatter()
//        dateFormatter.zeroFormattingBehavior = .pad
//        dateFormatter.includesApproximationPhrase = false
//        dateFormatter.includesTimeRemainingPhrase = false
//        dateFormatter.allowedUnits = [.minute,.second]
//        dateFormatter.calendar = Calendar.current
//
//        timerUpdater.setEventHandler { [weak self] in
//            guard let peak = AudioRecorderManager.shared.recorder else {
//                return
//            }
//
//            print("===========time" + dateFormatter.string(from: AudioRecorderManager.shared.recorder!.currentTime)!)
//            let percent = (Double(AudioRecorderManager.shared.recorderPeak0 + 160 )) / 160
//            let final = CGFloat(percent) + 0.3
//
//        }
//
//        timerUpdater.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(100))
//
//
//    }
//
//    func playRecordFile(){
//        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        print("file location:",url.path)
//        if FileManager.default.fileExists(atPath: url.path){
//            print("file found and read")
//            if AudioPlayerManager.shared.isPlaying{
//                print("file is playing")
//            } else {
//
//            }
//        } else {
//            let path = AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "Test")
//            AudioPlayerManager.shared.play(path: path)
//            print("file not found")
//        }
//    }
//
//    func replyAnswer(){
//        _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        apiProvider.request(.replyQuestion) { (result) in
//            switch result {
//            case let .success(response):
//                print(response)
//            case .failure:
//                print("failed")
//            }
//
//        }
//    }
//
//
    @IBAction func recordTapped(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecordingTemp()
        } else {
            finishRecording(success: true)
        }
    }
    
    @IBAction func btnSubmitPressed(_ sender: UIButton){
        let url = URL(fileURLWithPath: AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording"))
        var parameter = WYNAnswerQuestionParameters()
        parameter?.questionID = 174
        parameter?.audio = url
        parameter?.duration = 2
        parameter?.isFree = false
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

