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
class DebugPlugin: PluginType {
    
    static let targetKey = "target"
    /// Called by the provider as soon as the request is about to start
    func willSend(_ request: RequestType, target: TargetType) {
        if let request = request as? CustomDebugStringConvertible {
            
            print(request.debugDescription)
        }
    }
    
    func didReceive(_ result: Result<Moya.Response, Moya.MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            print(response.statusCode)
            do {
                let json = try response.mapJSON()
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        case let .failure(error):
            print(error.localizedDescription)
            break
        }
    }
}
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
//            .requestParameters(parameters: self.parameters!, encoding: JSONEncoding(options: []))
            return .request
        }
    }
    public var sampleData: Data {
        switch self {
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    
}
let endPoint = { (target: API) -> Endpoint<API> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var header: [String:String] = [:]
    header["X-App-Token"] = "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"
    return Endpoint<API>(url: url,
                         sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                         method: target.method,
                         parameters: target.parameters,
                         httpHeaderFields: header)
}
let apiProvider = MoyaProvider<API>(endpointClosure: endPoint,
                                    plugins: [NetworkLoggerPlugin(verbose: true)])
