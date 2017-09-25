//
//  MyServerAPI.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Alamofire
// 1:
enum MyServerAPI {
    
    // MARK: - Cameras
    case doctors(page: Int)
    case login(email: String, password: String)
    
    // MARK: - User
    case createUser(email: String, password: String)
}
// 2:
extension MyServerAPI: TargetType {
    var headers: [String : String]? {
        var h = ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"]
        switch self {
        case .doctors:
            h["X-Access-Token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNTA1ODkzNjI1LCJleHAiOjE1MTg4NTM2MjUsIm5iZiI6MTUwNTg5MzYyNSwianRpIjoiZ3U5S0FKU3V3bldsSVo5RCJ9.FHYE0EUGKk50aH5R0V9Buiwa9YsId2-jMYU5f-ETiUo"
        default:
            break
        }
        return h
    }
    
    // 3:
    var baseURL: URL { return URL(string: "https://wongyiunam-php.herokuapp.com/api")! }
    
    // 4:
    var path: String {
        switch self {
        case .doctors:
            return "/doctors"
        case .login:
            return "/auth/login"
        case .createUser:
            return "/user"
        }
    }
    
    // 5:
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }

    // 6:
//    var parameters: [String: Any]? {
//        switch self {
//        case .login(let email, let password):
//            var parameters = [String: Any]()
//            parameters["email"] = email
//            parameters["password"] = password
//            return parameters
//        default:
//            return nil
//        }
//    }
    
    // 7:
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    // 8:
    var sampleData: Data {
        return Data()
    }
    
    // 9:
    var task: Task {
        switch self {
        case .doctors(let page):
            var urlParameters = [String: Any]()
            urlParameters["page"] = page
            return Task.requestCompositeData(bodyData: Data(), urlParameters: urlParameters)
        case .login(let email, let password):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["password"] = password
            return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }
    }
}
