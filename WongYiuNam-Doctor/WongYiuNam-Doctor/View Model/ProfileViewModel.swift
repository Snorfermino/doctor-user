//
//  ProfileViewModel.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 10/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
protocol ProfileViewModelDelegate {
    func getDoctorProfileSuccess()
    func getDoctorProfileFailed()
    func doctor(isOnline: Bool)
}
class ProfileViewModel {
    var delegate:ProfileViewModelDelegate?
    
    init(_ delegate: ProfileViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getProfile(){
        apiProvider.request(.getDoctorProfile) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let result:WYNLogedInUserInfo = try response.mapObject(WYNLogedInUserInfo.self)
                        if result.toJSON().keys.count > 0 {
                            
                            UserDefaults.standard.set(result.toJSON(), forKey: "loggedIn")
                            UserDefaults.standard.synchronize()
                            self.delegate?.getDoctorProfileSuccess()
                        } else {
                            self.delegate?.getDoctorProfileFailed()
                        }
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.getDoctorProfileFailed()
                }
            case .failure:
                print("failed")
                self.delegate?.getDoctorProfileFailed()
            }
        }
    }
    
    func isOnline(_ value: Bool){
        apiProvider.request(.online(isOnline: value)) { (result) in
            switch result {
            case let .success(response):
                print(response)
                do {
                    let result:WYNLogedInUserInfo = try response.mapObject(WYNLogedInUserInfo.self)
                        
                        self.delegate?.doctor(isOnline: result.online!)

                } catch {
                    print(error.localizedDescription)
                    self.delegate?.doctor(isOnline: false)
                }
            case .failure:
                print("failed")
                self.delegate?.doctor(isOnline: false)
            }
        }
    }
}
