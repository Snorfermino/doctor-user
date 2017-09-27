//
//  API.swift
//  PHDMediaBookSale
//
//  Created by Phat Chiem on 5/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Alamofire

public enum API: TargetType{
    
    case login(email: String, passwd: String)
    case getUserProfile
    case getDoctorList
    case uploadPicture
    case replyQuestion
    case getPendingQuestion(userID: Int)
    case getAnswerHistory(userID: Int)
    case online(userID: Int)
    case offline(userID: Int)
    case reply(questionID: Int)
    case answerQuestion(questionID:String,fileURL:URL)
}

extension API {
    public var headers: [String : String]? {
        switch self {
        case .getPendingQuestion:
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                    "X-Access-Token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNTA1OTg0Mzc2LCJleHAiOjQ4MTYxOTg0Mzc2LCJuYmYiOjE1MDU5ODQzNzYsImp0aSI6ImVMQVVNWEFXZzFLT29wVHcifQ.7I3BYpbZE0np0mqyJ8_JszutHH7xCPQihGCzSImyZ2E"]
        case .answerQuestion:
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                    "X-Access-Token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNTA1OTg0Mzc2LCJleHAiOjQ4MTYxOTg0Mzc2LCJuYmYiOjE1MDU5ODQzNzYsImp0aSI6ImVMQVVNWEFXZzFLT29wVHcifQ.7I3BYpbZE0np0mqyJ8_JszutHH7xCPQihGCzSImyZ2E"]
        default :
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"]
        }
        
    }
    public var baseURL: URL {return URL(string: "https://wongyiunam-php.herokuapp.com/api")!}
    public var path: String {
        switch self {
        case .login:
            return "/doctor/login"
        case .getPendingQuestion(let id):
            return "/qas/doctor/\(id)/pending"
        case .getAnswerHistory(let id):
            return "/qas/doctor/\(id)/history"
        case .online(let id):
            return "/doctors/\(id)/online"
        case .offline(let id):
            return "/doctors/\(id)/offline"
        case .answerQuestion:
            return "/answer/reply"
        default:
            return "/"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getUserProfile, .getDoctorList, .getPendingQuestion, .getAnswerHistory:
            return .get
        case .replyQuestion, .online, .offline:
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
        case .answerQuestion(let qID,_):
            return ["question_id":"26","duration":"2","is_free":"false"]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.methodDependent
    }
    
    public var task: Task {
        switch self {
        case .getPendingQuestion, .getAnswerHistory:
            return .requestPlain
        case .answerQuestion(_, let url):
            let data = MultipartFormData(provider: .file(url), name: "audio", fileName: "Test.m4a", mimeType: "audio/m4a")
//            RequestMultipartFormData()
//            for key in (self.parameters?.keys)!{
//                let name = String(key)
//                if let val = parameters![name!] as? String{
//
//                    data.append(val.data(using: .utf8)!, withName: name!)
//
//                }
//            }
//            return .uploadFile(url)
            do {
//                let paraRawData = try JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
                let paraData = MultipartFormData(provider: .data("26".data(using: .utf8)!), name: "question_id")
                
                return .uploadMultipart([data,paraData])
            } catch {
                print("error")
            }
         
            return .uploadMultipart([data])
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
