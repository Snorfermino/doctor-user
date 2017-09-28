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
    

    var delegate: LoginViewModelDelegate?
    var pendingQuestions:[WYNDotorPendingQuestion.WYNData] = []
    
    init(_ delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func login(_ email: String, _ password: String){
        
        apiProvider.request(.login(email: email,passwd: password)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                if let receivedData: WYNLogedInUserInfo = Utils.mapOne(from: response) {
                    print(receivedData.dictionaryRepresentation())
                    UserDefaults.standard.set(receivedData, forKey: "loggedIn")
                    UserDefaults.standard.synchronize()
                    self.delegate?.loginSuccess()
                }
            case .failure:
                print("failed")
                // TODO: show error when failed
            }
        }
        
    }
}

