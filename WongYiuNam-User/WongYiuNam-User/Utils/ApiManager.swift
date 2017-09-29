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
    
    static func getDoctors(page: Int, completion: @escaping (([Doctor]) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.doctors(page: page)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let doctorsResponse = try response.mapObject(PagingResponse<Doctor>.self)
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
    
    static func login(email: String, password: String, completion: @escaping ((User?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.login(email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let userResponse = try response.mapObject(User.self)
                    completion(userResponse, nil)
                } catch {
                    do {
                        let err = try response.mapJSON() as! [String]
                        completion(nil, err[0])
                    } catch {
                        completion(nil, "Error login")
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func askaQuestion(question: Question, completion:  (() -> Void)?) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.askaQuestion(question: question)) { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func register(name: String, email: String, password: String, completion: @escaping ((User?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.register(name: name, email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                if(response.statusCode == 200) {
                    do {
                        let userResponse = try response.mapObject(User.self)
                        completion(userResponse, nil)
                    } catch {
                        //
                    }
                } else {
                    completion(nil, self.parseError(response: response))
                }
                completion(nil, nil)
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func parseError(response: Response) -> String? {
        do {
            let errorResponse = try response.mapObject(ErrorResponse.self)
            return errorResponse.msg
        } catch {
            return nil
        }
    }
}

