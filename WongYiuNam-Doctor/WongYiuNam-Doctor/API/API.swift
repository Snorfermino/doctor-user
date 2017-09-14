//
//  API.swift
//  PHDMediaBookSale
//
//  Created by Phat Chiem on 5/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Foundation
import Result

public enum API: TargetType{
    
    case login(email: String, passwd: String)
    case getUserProfile
    case getDoctorList
    case uploadPicture
    
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
            
        default:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
            
        default:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.methodDependent
    }
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    public var sampleData: Data {
        return Data()
    }
    
    
}
let apiProvider
