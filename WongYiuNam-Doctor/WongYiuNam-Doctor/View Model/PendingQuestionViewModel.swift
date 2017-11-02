//
//  PendingQuestionViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/21/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import UIKit
import Moya_ObjectMapper
protocol PendingQuestionViewModelDelegate{
    func getPendingQuestionListSuccess()
    func getPendingQuestionListFailed()
}
class PendingQuestionViewModel{

    init() {}
    var delegate: PendingQuestionViewModelDelegate?
    var pendingQuestions:[WYNQuestion] = []
    func getPendingQuestionList(){
        
        apiProvider.request(.getPendingQuestion) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let resultData:WYNDotorPendingQuestion = try response.mapObject(WYNDotorPendingQuestion.self) {
                        if resultData.data != nil {
                            self.pendingQuestions.removeAll()
                            for question in resultData.data! {
                                self.pendingQuestions.append(question)
                            }
                            print("Count: \(self.pendingQuestions.count)")
                            self.delegate?.getPendingQuestionListSuccess()
                        } else {
                            self.delegate?.getPendingQuestionListFailed()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.getPendingQuestionListFailed()
                }
            case .failure:
                print("failed")
            }
        }
    }
}
