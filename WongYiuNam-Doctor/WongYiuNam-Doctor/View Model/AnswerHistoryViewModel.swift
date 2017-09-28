//
//  AnswerHistoryViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation

protocol AnswerHistoryViewModelDelegate {
    func getAnswerHistoryListSuccess()
}
class AnswerHistoryViewModel {
    var delegate: AnswerHistoryViewModelDelegate?
    var answerHistory:[WYNDotorPendingQuestion.WYNData] = []
    
    
    init(_ delegate: AnswerHistoryViewController){
        self.delegate = delegate as AnswerHistoryViewModelDelegate
    }
    func getAnswerHistoryList(){
        
        apiProvider.request(.getAnswerHistory) { (result) in
            switch result {
            case let .success(response):
                if let receivedData: WYNDotorPendingQuestion = Utils.mapOne(from: response) {
                    print(receivedData.dictionaryRepresentation())
                    for question in receivedData.data! {
                        self.answerHistory.append(question)
                    }
                    print("Count: \(self.answerHistory.count)")
                    self.delegate?.getAnswerHistoryListSuccess()
                }
            case .failure:
                print("failed")
            }
        }
    }
    
}
