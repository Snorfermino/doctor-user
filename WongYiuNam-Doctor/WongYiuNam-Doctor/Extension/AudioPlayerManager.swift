//
//  AudioPlayerManager.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayerManager: NSObject {
    static let shared = AudioPlayerManager()
    var isPlaying = false
    var isFinished = false
    var lastPath: String?
    override init(){
        super.init()
    }
    
    private var currentPlayer: AVAudioPlayer?
    
    func play(path:String){
        if lastPath == path && isFinished == false {
            self.currentPlayer?.play()
            return 
        }
        let url = URL(fileURLWithPath: path)
        do{
            self.currentPlayer = try AVAudioPlayer(contentsOf: url)
            self.currentPlayer?.delegate = self
            self.currentPlayer?.play()
            isPlaying = true
            isFinished = false
            lastPath = url.path
        }catch{
            print("Error loading file", error.localizedDescription)
        }
    }
    
    func pause(){
        isPlaying = false
        self.currentPlayer?.pause()
    }
    
    func audioFileInUserDocuments(fileName: String)->String{
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent(fileName+".m4a").path
        
    }
}
extension AudioPlayerManager: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isFinished = true
        isPlaying = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print(error?.localizedDescription ?? "")
    }
}
