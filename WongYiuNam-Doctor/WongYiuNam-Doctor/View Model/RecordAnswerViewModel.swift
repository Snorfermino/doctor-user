//
//  File.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
protocol RecordAnswerViewModelDelegate {
    func replyQuestionSuccess()
    func replyQuestionFailed()
}
class RecordAnswerViewModel {
    var delegate: RecordAnswerViewModelDelegate?
    
    init(_ delegate: RecordAnswerViewModelDelegate){
        self.delegate = delegate
    }
    func replyQuestion(_ sender: WYNAnswerQuestion){
        apiProvider.request(.answerQuestion(sender: sender)) { (result) in
            switch result {
            case let .success(response):
                print("========\(response)")
                self.delegate?.replyQuestionSuccess()
            case .failure:
                print("failed")
                self.delegate?.replyQuestionFailed()
            }
        }
        
        
    }
}
