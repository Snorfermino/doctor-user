//
//  API.swift
//  PHDMediaBookSale
//
//  Created by Phat Chiem on 5/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya

public enum API: TargetType{
    
    case login(email: String, passwd: String)
    case getUserProfile
    case getDoctorList
    case uploadPicture
    case replyQuestion
    
}

extension API {
    public var headers: [String : String]? {
        return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"]
    }
    public var baseURL: URL {return URL(string: "https://wongyiunam-php.herokuapp.com/api")!}
    public var path: String {
        switch self {
        case .login:
            return "/auth/login"
        default:
            return "/"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getUserProfile, .getDoctorList:
            return .get
        case .replyQuestion:
            return .put
        default:
            return .post
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .login(let email, let pwd):
            return ["email":email,"password":pwd]
//        case .replyQuestion(let answer):
//            return ["content":answer]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.methodDependent
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: self.parameters!, encoding: self.parameterEncoding)
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
}

let apiProvider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: true)])
