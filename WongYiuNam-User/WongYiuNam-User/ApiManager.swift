//
//  ApiManager.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Moya_ObjectMapper

class ApiManager {
    static func getDoctors(completion: @escaping (([Doctor]) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>()
        provider.request(.doctors) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let doctorsResponse: PagingResponse<Doctor> = try response.mapObject(PagingResponse<Doctor>.self)
                    if let doctors = doctorsResponse.data {
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
