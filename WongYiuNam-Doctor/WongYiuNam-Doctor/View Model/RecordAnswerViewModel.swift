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
}
class RecordAnswerViewModel {
    var delegate: RecordAnswerViewModelDelegate?
    
    func replyQuestion(_ sender: WYNAnswerQuestionParameters){
        apiProvider.request(.answerQuestion(sender: sender)) { (result) in
            switch result {
            case let .success(response):
              print("========\(response)")
            case .failure:
                print("failed")
            }
        }
        
        
    }
}
