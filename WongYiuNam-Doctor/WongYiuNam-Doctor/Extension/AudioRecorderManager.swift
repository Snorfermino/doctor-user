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
            
            
            switch AVAudioSession.sharedInstance().recordPermission() {
            case AVAudioSessionRecordPermission.granted:
                print("Permission granted")
            case AVAudioSessionRecordPermission.denied:
                print("Pemission denied")
            case AVAudioSessionRecordPermission.undetermined:
                print("Request permission here")
            default:
                break
            }
            
            
        } catch {
            print("There is an error with audio record", error.localizedDescription)
        }
    }
    
    func record(_ fileName:String){
        let url = getUserPath().appendingPathComponent(fileName + ".m4a")
        let audioURL = URL.init(fileURLWithPath: url.path)
        let recordSettings:[String:Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 44100,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
//        do {
//            recorder = try AVAudioRecorder(url: audioURL,)
//        }
    
    }
    func getUserPath()-> URL {
     return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
