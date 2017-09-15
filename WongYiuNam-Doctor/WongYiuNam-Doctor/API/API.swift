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
        case .login(let email, let pwd):
//
//             do {
//                let jsonData = try JSONSerialization.data(withJSONObject: ["email":email,"password":pwd], options: .prettyPrinted)
//                // here "jsonData" is the dictionary encoded in JSON data
//                
//
//                // here "decoded" is of type `Any`, decoded from JSON data
//                
//                // you can now cast it with the right type
//                let data = MultipartFormData(provider: 	.data(jsonData), name: "something"), name: "something")
//                return data
//             } catch {
//                print(error.localizedDescription)
//             }
            return ["email":email,"password":pwd]
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
            return .requestParameters(parameters: self.parameters!, encoding: JSONEncoding(options: []))
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
    header["Content-Type"] = "application/x-www-form-urlencoded"
    return Endpoint<API>(url: url,
                         sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                         method: target.method,
                         task: target.task,
                         httpHeaderFields: header)
}
let apiProvider = MoyaProvider<API>(endpointClosure: endPoint,
                                    plugins: [DebugPlugin()])
