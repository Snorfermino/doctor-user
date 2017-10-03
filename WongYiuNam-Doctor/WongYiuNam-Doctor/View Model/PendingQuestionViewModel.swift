//
//  PendingQuestionViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/21/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import UIKit
protocol PendingQuestionViewModelDelegate{
    func getPendingQuestionListSuccess()
    func getPendingQuestionListFailed()
}
class PendingQuestionViewModel{
    
    init() {}
    var delegate: PendingQuestionViewModelDelegate?
    var pendingQuestions:[WYNDotorPendingQuestion.WYNData] = []
    func getPendingQuestionList(){
        
        apiProvider.request(.getPendingQuestion) { (result) in
            switch result {
            case let .success(response):
                if let receivedData: WYNDotorPendingQuestion = Utils.mapOne(from: response) {
                    print(receivedData.toJSON())
                    if receivedData.data != nil {
                    for question in receivedData.data! {
                        self.pendingQuestions.append(question)
                    }
                    print("Count: \(self.pendingQuestions.count)")
                    self.delegate?.getPendingQuestionListSuccess()
                    } else {
                         self.delegate?.getPendingQuestionListFailed()
                    }
                } else {
                    self.delegate?.getPendingQuestionListFailed()
                }
            case .failure:
                print("failed")
            }
        }
    }
}
