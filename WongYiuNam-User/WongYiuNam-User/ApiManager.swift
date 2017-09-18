//
//  ApiManager.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Moya_ModelMapper

class ApiManager {
    static func getDoctors(completion: @escaping (([Doctor]) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>()
        provider.request(.doctors) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let doctorsResponse: DoctorsResponse = try response.map(to: DoctorsResponse.self)
                    if let doctors = doctorsResponse.doctors {
                        completion(doctors)
                    } else {
                        completion([])
                    }
                } catch {
                    completion([])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
