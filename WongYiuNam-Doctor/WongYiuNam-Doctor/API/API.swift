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
    case getDoctorProfile
    case uploadPicture
    case replyQuestion
    case getPendingQuestion(userID: Int)
    case getAnswerHistory(userID: Int)
    case online(isOnline: Bool)
    case reply(questionID: Int)
    case answerQuestion(sender: WYNAnswerQuestionParameters)
}

extension API {
    public var headers: [String : String]? {
        switch self {
        case .getPendingQuestion:
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                    "X-Access-Token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUxLCJpc3MiOiJodHRwOi8vd29uZ3lpdW5hbS1waHAuaGVyb2t1YXBwLmNvbS9hcGkvZG9jdG9yL2xvZ2luIiwiaWF0IjoxNTA2NTA2ODA0LCJleHAiOjQ4MTYyNTA2ODA0LCJuYmYiOjE1MDY1MDY4MDQsImp0aSI6InRXWVFlaWFvajEwYlBCZnAifQ.xvTR5rQicUeOCszGvdtCh0BFe0Q7ZHHIhjlC3RpRVvs"]
        case .answerQuestion:
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                    "X-Access-Token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUxLCJpc3MiOiJodHRwOi8vd29uZ3lpdW5hbS1waHAuaGVyb2t1YXBwLmNvbS9hcGkvZG9jdG9yL2xvZ2luIiwiaWF0IjoxNTA2NTA2ODA0LCJleHAiOjQ4MTYyNTA2ODA0LCJuYmYiOjE1MDY1MDY4MDQsImp0aSI6InRXWVFlaWFvajEwYlBCZnAifQ.xvTR5rQicUeOCszGvdtCh0BFe0Q7ZHHIhjlC3RpRVvs"]
        default :
            return ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF",
                    "X-Access-Token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjUxLCJpc3MiOiJodHRwOi8vd29uZ3lpdW5hbS1waHAuaGVyb2t1YXBwLmNvbS9hcGkvZG9jdG9yL2xvZ2luIiwiaWF0IjoxNTA2NTA2ODA0LCJleHAiOjQ4MTYyNTA2ODA0LCJuYmYiOjE1MDY1MDY4MDQsImp0aSI6InRXWVFlaWFvajEwYlBCZnAifQ.xvTR5rQicUeOCszGvdtCh0BFe0Q7ZHHIhjlC3RpRVvs",
                    "Content-Type":"application/x-www-form-urlencoded"]
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
        case .getDoctorProfile:
            return "/user"
        case .online:
            return "/doctors/online"
        case .answerQuestion:
            return "/answer/reply"
        default:
            return "/"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .getUserProfile, .getDoctorProfile, .getPendingQuestion, .getAnswerHistory:
            return .get
        case .replyQuestion, .online:
            return .put
        default:
            return .post
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .login(let email, let pwd):
            return ["email":email,"password":pwd]
        case .answerQuestion(let sender):
            return sender.toJSON()
        case .online(let isOnline):
            return ["online":isOnline.description]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.methodDependent
    }
    
    public var task: Task {
        switch self {
        case .getPendingQuestion, .getAnswerHistory, .getDoctorProfile:
            return .requestPlain
        case .answerQuestion(let sender):
            guard let fileURL = sender.audio else  { return .requestPlain }
            var multipartdata:[MultipartFormData] = []
            multipartdata.append(MultipartFormData(provider: .file(fileURL), name: "audio", fileName: "Test.m4a", mimeType: "audio/m4a"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.questionID).data(using: .utf8)!), name: "question_id"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.duration).data(using: .utf8)!), name: "duration"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.isFree).data(using: .utf8)!), name: "is_free"))
            return .uploadMultipart(multipartdata)
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
