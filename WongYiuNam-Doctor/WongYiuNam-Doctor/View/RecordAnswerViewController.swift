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
    
    @IBOutlet weak var btnRecord:UIButton!
    var viewModel: RecordAnswerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RecordAnswerViewModel()
    }

    
    var isRecording = false
     var timerUpdater = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    func startRecording() {
        isRecording = true
              if AudioRecorderManager.shared.record("Test"){
            timerUpdater.resume()
        }
        
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.zeroFormattingBehavior = .pad
        dateFormatter.includesApproximationPhrase = false
        dateFormatter.includesTimeRemainingPhrase = false
        dateFormatter.allowedUnits = [.minute,.second]
        dateFormatter.calendar = Calendar.current
        
        timerUpdater.setEventHandler {
            guard let peak = AudioRecorderManager.shared.recorder else {
                return
            }
            
            print("===========time" + dateFormatter.string(from: AudioRecorderManager.shared.recorder!.currentTime)!)
//            let percent = (Double(AudioRecorderManager.shared.recorderPeak0 + 160 )) / 160
//            let final = CGFloat(percent) + 0.3

        }
        
        timerUpdater.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(100))

        
    }
    
    func playRecordFile(){
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("file location:",url.path)
        if FileManager.default.fileExists(atPath: url.path){
            print("file found and read")
            if AudioPlayerManager.shared.isPlaying{
                print("file is playing")
            } else {
                
            }
        } else {
            let path = AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "Test")
            AudioPlayerManager.shared.play(path: path)
            print("file not found")
        }
    }
    
    func replyAnswer(){
        _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        apiProvider.request(.replyQuestion) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case .failure:
                print("failed")
            }
            
        }
    }

    
    @IBAction func recordTapped(_ sender: UIButton) {
        if isRecording == false {
            startRecording()
        } else {
            AudioRecorderManager.shared.finishRecording()
            timerUpdater.cancel()
            playRecordFile()
//            finishRecording(success: true)
        }
    }
    
    @IBAction func btnSubmitPressed(_ sender: UIButton){
        let url = URL(fileURLWithPath: AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "Test"))
        viewModel.replyQuestion("26", url: url)
    }
}
