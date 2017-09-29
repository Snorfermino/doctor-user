//
//  MyServerAPI.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
//import Alamofire

enum MyServerAPI {
    
    // MARK: - Doctor
    case doctors(page: Int)
    case askaQuestion(question: Question)
    // MARK: User
    case login(email: String, password: String)
    case register(name: String, email: String, password: String)
}

extension MyServerAPI: TargetType {
    var headers: [String : String]? {
        var h = ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"]
        switch self {
        case .doctors, .askaQuestion:
            h["X-Access-Token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNTA2NTMwNDI1LCJleHAiOjQ4MTYyNTMwNDI1LCJuYmYiOjE1MDY1MzA0MjUsImp0aSI6InRYZG1Pb2NMVDBBOUlyM3QifQ.ijzz45iAXz0RvhhUVyFnPZYzU8EdZa1tnYZci90ZbKk"
        default:
            break
        }
        return h
    }
    
    var baseURL: URL {
        return URL(string: "https://wongyiunam-php.herokuapp.com/api")!
    }
    
    var path: String {
        switch self {
        case .doctors:
            return "/doctor/list"
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        case .askaQuestion:
            return "/question/ask"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .askaQuestion, .register:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        let encoding = URLEncoding.methodDependent
        switch self {
        case .doctors(let page):
            var urlParameters = [String: Any]()
            urlParameters["page"] = page
            return Task.requestCompositeData(bodyData: Data(), urlParameters: urlParameters)
        case .login(let email, let password):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["password"] = password
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .register(let name, let email, let password):
            var parameters = [String: Any]()
            parameters["name"] = name
            parameters["email"] = email
            parameters["password"] = password
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .askaQuestion(let question):
            guard let data = UIImageJPEGRepresentation(question.photo!,1) else {
                return Task.requestPlain
            }
            var multipartdata:[MultipartFormData] = []
            multipartdata.append(MultipartFormData(provider: .data(data), name: "photo", fileName: "photo.jpg", mimeType: "image/jpg"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: question.doctorID!).data(using: .utf8)!), name: "doctor"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: question.patientName!).data(using: .utf8)!), name: "patient_name"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: "10/10/9999").data(using: .utf8)!), name: "patient_dob"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: question.patientGender!).data(using: .utf8)!), name: "patient_gender"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: question.symptomType!).data(using: .utf8)!), name: "symptom_type"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: question.question!).data(using: .utf8)!), name: "question"))
            multipartdata.append(MultipartFormData(provider: .data(String(describing: "true").data(using: .utf8)!), name: "is_public"))
            return .uploadMultipart(multipartdata)
        default:
            return Task.requestPlain
        }
    }
}



