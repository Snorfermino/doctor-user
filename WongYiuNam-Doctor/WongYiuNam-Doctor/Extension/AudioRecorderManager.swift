//
//  AudioRecorderManager.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import AVFoundation
class AudioRecorderManager: NSObject {
    
    static let shared = AudioRecorderManager()

    var recordSession: AVAudioSession!
    var recorder: AVAudioRecorder!
    
    func setup(){
        recordSession = AVAudioSession.sharedInstance()
        
        do {
            try recordSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordSession.setActive(true)
            
            recordSession.requestRecordPermission({ (allowed:Bool) in
                if allowed {
                    print("Mic Authorized")
                } else {
                    print("Mic not authorized")
                }
            })
            
            switch AVAudioSession.sharedInstance().recordPermission() {
            case AVAudioSessionRecordPermission.granted:
                print("Permission granted")
            case AVAudioSessionRecordPermission.denied:
                print("Pemission denied")
            case AVAudioSessionRecordPermission.undetermined:
                print("Request permission here")
            }
            
            
        } catch {
            print("There is an error with audio record", error.localizedDescription)
        }
    }
    var recorderApc0:Float = 0
    var recorderPeak0:Float = 0
    var meterTimer:Timer?
    //Start record session
    func record(_ fileName:String) -> Bool {
        let url = getUserPath().appendingPathComponent(fileName + ".m4a")
        let audioURL = URL.init(fileURLWithPath: url.path)
        let recordSettings:[String:Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVEncoderBitRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 44100,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: audioURL, settings: recordSettings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
            
            self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateMeterTimer), userInfo: nil, repeats: true)
            return true
        } catch {
            print("Error Recording")
            return false
        }
    }
    
    @objc func updateMeterTimer() {
        if let recorder = self.recorder {
            recorder.updateMeters()
            self.recorderApc0 = recorder.averagePower(forChannel: 0 )
            self.recorderPeak0 = recorder.peakPower(forChannel: 0)
        }
    }
    
    func finishRecording(){
        self.recorder?.stop()
        self.meterTimer?.invalidate()
    }
    func getUserPath()-> URL {
     return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension AudioRecorderManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Did finish recording")
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?){
        print("Error encoding", error?.localizedDescription ?? "")
    }

}
