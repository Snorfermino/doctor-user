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
    override init() {
        super.init()
        setup()
    }
    
    func setup(){
        recordSession = AVAudioSession.sharedInstance()
        let url = getUserPath().appendingPathComponent("Test.m4a")
        let audioURL = URL.init(fileURLWithPath: url.path)
        let recordSettings:[String:Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVEncoderBitRateKey: 32000,
            //            AVLinearPCMBitDepthKey: 16,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]
        do {
            try recordSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordSession.setActive(true)
            recorder = try AVAudioRecorder(url: audioURL, settings: recordSettings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
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
            default:
                print("Default")
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
        print("pre-recording")
        recorder?.record(forDuration: 12000)
        if #available(iOS 10.0, *) {
            self.meterTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
                if let recorder = self.recorder {
                    recorder.updateMeters()
                    self.recorderApc0 = recorder.averagePower(forChannel: 0 )
                    self.recorderPeak0 = recorder.peakPower(forChannel: 0)
                }
            })
        } else {
            // Fallback on earlier versions
        }
        self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateMeterTimer), userInfo: nil, repeats: true)
        return true
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
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
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
