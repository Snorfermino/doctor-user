//
//  File.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import Moya_ObjectMapper
protocol RecordAnswerViewModelDelegate {
    func replyQuestionSuccess(result:WYNRecordAnswerResult)
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
                do {
                    let receivedData: WYNRecordAnswerResult = try response.mapObject(WYNRecordAnswerResult.self)
                    print("======Response: \(receivedData)")
                    self.delegate?.replyQuestionSuccess(result: receivedData)
                    
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.replyQuestionFailed()
                }
                
                
            case .failure:
                print("failed")
                self.delegate?.replyQuestionFailed()
            }
        }
        
        
    }
}
