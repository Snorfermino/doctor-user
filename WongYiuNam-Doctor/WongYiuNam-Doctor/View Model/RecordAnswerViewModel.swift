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
    
    func replyQuestion(_ questionID: String, url: URL){
        apiProvider.request(.answerQuestion(questionID: questionID,fileURL:url)) { (result) in
            switch result {
            case let .success(response):
              print("========\(response)")
            case .failure:
                print("failed")
            }
        }
        
        
    }
}
