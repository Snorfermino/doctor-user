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
    func getPendingQuestionListDone()
}
class PendingQuestionViewModel{
    
    init() {}
    var delegate: PendingQuestionViewModelDelegate?
    var pendingQuestions:[WYNDotorPendingQuestion.WYNData] = []
    func getPendingQuestionList(id: Int){
        
        apiProvider.request(.getPendingQuestion(userID: id)) { (result) in
            switch result {
            case let .success(response):
                if let receivedData: WYNDotorPendingQuestion = Utils.mapOne(from: response) {
                    print(receivedData.dictionaryRepresentation())
                    for question in receivedData.data! {
                        self.pendingQuestions.append(question)
                    }
                    print("Count: \(self.pendingQuestions.count)")
                    self.delegate?.getPendingQuestionListDone()
                }
            case .failure:
                print("failed")
            }
        }
    }
}
