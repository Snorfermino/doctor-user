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
    case logout
    case getUserProfile
    case getDoctorList
    case getDoctorProfile
    case uploadPicture
    case replyQuestion
    case getPendingQuestion
    case getAnswerHistory
    case online(isOnline: Bool)
    case reply(questionID: Int)
    case answerQuestion(sender: WYNAnswerQuestion)
}

extension API {
    public var headers: [String : String]? {
        switch self {
        case .login:
            return ["X-App-Token": UserLoginInfo.shared.getAppToken()]

        default :
            return ["X-App-Token": UserLoginInfo.shared.getAppToken(),
                    "X-Access-Token":UserLoginInfo.shared.userInfo.token!]
        }
    }
    public var baseURL: URL {return URL(string: "https://wongyiunam-php.herokuapp.com/api")!}
    public var path: String {
        switch self {
        case .login:
            return "/doctor/login"
        case .logout:
            return "/user/logout"
        case .getPendingQuestion:
            return "/doctor/questions/pendings"
        case .getAnswerHistory:
            return "/doctor/answers/history"
        case .getDoctorProfile:
            return "/doctor/profile"
        case .online:
            return "/doctors/online"
        case .answerQuestion:
            return "/doctor/answers/reply"
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
            let url = URL(fileURLWithPath: AudioPlayerManager.shared.audioFileInUserDocuments(fileName: "recording"))
            let multipart = MultipartFormData(provider: .file(url), name: "audio", fileName: "recording.m4a", mimeType: "audio/m4a")

            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.questionID).data(using: .utf8)!), name: "question_id"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.duration).data(using: .utf8)!), name: "duration"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: sender.isFree).data(using: .utf8)!), name: "is_free"))
            return .uploadCompositeMultipart([multipart], urlParameters: ["question_id": sender.questionID, "is_free": sender.isFree, "duration": sender.duration])
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
