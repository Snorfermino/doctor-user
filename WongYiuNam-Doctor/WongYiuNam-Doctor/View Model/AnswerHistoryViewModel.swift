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
    func getAnswerHistoryListFailed()
}
class AnswerHistoryViewModel {
    var delegate: AnswerHistoryViewModelDelegate?
    var answerHistory:[WYNAnswerHistory.WYNData] = []
    
    
    init(_ delegate: AnswerHistoryViewController){
        self.delegate = delegate as AnswerHistoryViewModelDelegate
    }
    func getAnswerHistoryList(){
        
        apiProvider.request(.getAnswerHistory) { (result) in
            switch result {
            case let .success(response):
                if let receivedData: WYNAnswerHistory = Utils.mapOne(from: response) {
                    print(receivedData.toJSON())
                    if receivedData.data != nil {
                        for question in receivedData.data! {
                            self.answerHistory.append(question)
                        }
                        print("Count: \(self.answerHistory.count)")
                        self.delegate?.getAnswerHistoryListSuccess()
                        
                    } else {
                        self.delegate?.getAnswerHistoryListFailed()
                    }
                } else {
                    self.delegate?.getAnswerHistoryListFailed()
                }
            case .failure:
                print("failed")
            }
        }
    }
    
}
