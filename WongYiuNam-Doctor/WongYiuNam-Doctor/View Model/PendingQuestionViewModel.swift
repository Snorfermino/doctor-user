//
//  PendingQuestionViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/21/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation

class PendingQuestionViewModel{
    
    init() {}
    
    var pendingQuestions:[WYNDotocPendingQuestion.WYNData] = []
    func getPendingQuestionList(id: Int){
  
        apiProvider.request(.getPendingQuestion(userID: id)) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case .failure:
                print("failed")
            }
            
        }
        
    }
}
