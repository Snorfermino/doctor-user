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
    case doctors
    case settingsFor(cameraId: String)
    
    // MARK: - User
    case createUser(email: String, password: String)
}
// 2:
extension MyServerAPI: TargetType {
    var headers: [String : String]? {
        let h = ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                 "X-Access-Token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNTA1ODAzNTI2LCJleHAiOjE1MDU4MDcxMjYsIm5iZiI6MTUwNTgwMzUyNiwianRpIjoieldsdVFNQjRkNU81NHk4SyJ9.J3Gad-HiSEA2mtMAbehZ_N3IbIimjmTVBNy1e7m230U"]
        return h
    }
    
    // 3:
    var baseURL: URL { return URL(string: "https://wongyiunam-php.herokuapp.com/api")! }
    
    // 4:
    var path: String {
        switch self {
        case .doctors:
            return "/doctors"
        case .settingsFor(let cameraId):
            return "/cameras/\(cameraId)/settings"
        case .createUser:
            return "/user"
        }
    }
    
    // 5:
    var method: Moya.Method {
        switch self {
        case .createUser:
            return .post
        default:
            return .get
        }
    }
    
    // 6:
    var parameters: [String: Any]? {
        switch self {
        case .createUser(let email, let password):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["password"] = password
            return parameters
        default:
            return nil
        }
    }
    
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
        return .requestPlain
    }
}
