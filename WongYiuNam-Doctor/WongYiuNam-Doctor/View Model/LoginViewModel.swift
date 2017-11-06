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
    func loginFailed()
}
class LoginViewModel{
    
    var delegate: LoginViewModelDelegate?
    var pendingQuestions:[WYNQuestion] = []
    
    init(_ delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func login(_ email: String, _ password: String){
        
        apiProvider.request(.login(email: email,passwd: password)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    if let result:WYNLogedInUserInfo = try response.mapObject(WYNLogedInUserInfo.self) {
                        if result.toJSON().keys.count > 0 {
                            
                            UserDefaults.standard.set(result.toJSON(), forKey: "loggedIn")
                            UserDefaults.standard.synchronize()
                            self.delegate?.loginSuccess()
                        } else {
                            self.delegate?.loginFailed()
                        }
                    } else {
                        self.delegate?.loginFailed()
                    }
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.loginFailed()
                }
            case .failure:
                print("failed")
                self.delegate?.loginFailed()
            }
        }
        
    }
}
