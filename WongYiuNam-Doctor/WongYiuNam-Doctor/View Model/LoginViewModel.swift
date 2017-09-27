//
//  PendingQuestionViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/21/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import UIKit
protocol LoginViewModelDelegate{
    func loginSuccess()
}
class LoginViewModel{
    
    init() {}
    var delegate: PendingQuestionViewModelDelegate?
    var pendingQuestions:[WYNDotorPendingQuestion.WYNData] = []
    func getPendingQuestionList(_ email: String, _ password: String){
        
        apiProvider.request(.login(email: email,passwd: password)) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case .failure:
                print("failed")
                // TODO: show error when failed
            }
        }
        
    }
}

