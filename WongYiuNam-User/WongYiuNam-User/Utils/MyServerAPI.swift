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
    case askaQuestion(question: QuestionUpload)
    case answerList(page: Int)
    case favouritesDoctors
    case saveFavoritesDoctor(doctorId: Int)
    case deleteFavoritesDoctor(doctorId: Int)
    case favoritesQuestions
    case favoritesAnswers
    case saveFavoritesAnswer(answerId: Int)
    case deleteFavoritesAnswer(answerId: Int)
    // MARK: User
    case login(email: String, password: String)
    case loginViaFacebook(email: String, name: String, fbId: String)
    case logout
    case register(name: String, email: String, password: String)
    case changePassword(oldPassword: String, newPassword: String)
    case updateUserProfile(user: User)
    case getUserProfile
    // MARK: Social Wall
    case getPostsFromFanpageFacebook
    case getPostsFromFanpageFacebookNext(nextPage: String)
    case getVideosFromYoutube
    case getVideosFromYoutubeNext(nextPage: String)
    // MARK: Payment
    case getPaymentToken
}

extension MyServerAPI: TargetType {
    
    var headers: [String : String]? {
        var h = ["X-App-Token": "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"]
        guard let accessToken = Global.user?.token else {
            return h
        }
        h["X-Access-Token"] = accessToken
        return h
    }
    
    var baseURL: URL {
        switch self {
        case .getPostsFromFanpageFacebook, .getPostsFromFanpageFacebookNext:
            return URL(string: "https://graph.facebook.com/304466529572881/posts")!
        case .getVideosFromYoutube, .getVideosFromYoutubeNext:
            return URL(string: "https://www.googleapis.com/youtube/v3/search")!
        default:
            return URL(string: "https://wongyiunam-php.herokuapp.com/api")!
        }
    }
    
    var path: String {
        switch self {
        case .doctors:
            return "/user/doctor/list"
        case .favouritesDoctors, .saveFavoritesDoctor, .deleteFavoritesDoctor:
            return "/user/favourites/doctors"
        case .favoritesQuestions:
            return "/user/favourites/questions"
        case .favoritesAnswers, .saveFavoritesAnswer, .deleteFavoritesAnswer:
            return "/user/favourites/answers"
        case .answerList:
            return "/answer/list"
        case .login:
            return "/user/login"
        case .loginViaFacebook:
            return "/user/signin_via_fb"
        case .logout:
            return "/user/logout"
        case .register:
            return "/auth/register"
        case .askaQuestion:
            return "/question/ask"
        case .changePassword:
            return "/user/changepass"
        case .updateUserProfile, .getUserProfile:
            return "/user/profile"
        case .getPaymentToken:
            return "/payment/token"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .loginViaFacebook, .askaQuestion, .register, .changePassword, .saveFavoritesDoctor, .saveFavoritesAnswer:
            return .post
        case .deleteFavoritesDoctor, .deleteFavoritesAnswer:
            return .delete
        case .updateUserProfile:
            return .put
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
        case .doctors(let page), .answerList(let page):
            var urlParameters = [String: Any]()
            urlParameters["page"] = page
            return Task.requestCompositeData(bodyData: Data(), urlParameters: urlParameters)
        case .saveFavoritesDoctor(let doctorId), .deleteFavoritesDoctor(let doctorId):
            var parameters = [String: Any]()
            parameters["doctor_id"] = doctorId
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .saveFavoritesAnswer(let answerId), .deleteFavoritesAnswer(let answerId):
            var parameters = [String: Any]()
            parameters["answer_id"] = answerId
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .login(let email, let password):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["password"] = password
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .updateUserProfile(let user):
            var parameters = [String: Any]()
            parameters["name"] = user.info?.name
            parameters["email"] = user.email
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .loginViaFacebook(let email, let name, let fbId):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["name"] = name
            parameters["fbid"] = fbId
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
        case .changePassword(let oldPassword, let newPassword):
            var parameters = [String: Any]()
            parameters["old_password"] = oldPassword
            parameters["new_password"] = newPassword
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .getPostsFromFanpageFacebook:
            var parameters = [String: Any]()
            parameters["fields"] = "likes.limit(0).summary(true),comments.limit(0).summary(true),shares.limit(0).summary(true),message,attachments"
            parameters["access_token"] = "EAAcYiSAGPRIBAN5oMxmxylboZBaB0ZCYhPUU6A4MVltw9O4KFJHLHWRmxb7xuL6ubwDx4pg0M90MMADwC8s0aEOLaHwHTyCZCBVFNHrNIZB6l7LZBRsRdIBOdwI7tk91RApOOp73og1S86HZCXw7y9StOgVMI0kfuUeEcMoNclqnNZAXUuWYkgaTEUTzfui1fF7EiZAPQdnGYD4x6OrdvKfpzpDDlJ4RaXO5d8AX8qXxjAZDZD"
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .getPostsFromFanpageFacebookNext(let nextPage):
            var parameters = [String: Any]()
            parameters["fields"] = "likes.limit(0).summary(true),comments.limit(0).summary(true),shares.limit(0).summary(true),message,attachments"
            parameters["access_token"] = "EAAcYiSAGPRIBAN5oMxmxylboZBaB0ZCYhPUU6A4MVltw9O4KFJHLHWRmxb7xuL6ubwDx4pg0M90MMADwC8s0aEOLaHwHTyCZCBVFNHrNIZB6l7LZBRsRdIBOdwI7tk91RApOOp73og1S86HZCXw7y9StOgVMI0kfuUeEcMoNclqnNZAXUuWYkgaTEUTzfui1fF7EiZAPQdnGYD4x6OrdvKfpzpDDlJ4RaXO5d8AX8qXxjAZDZD"
            parameters["after"] = nextPage
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .getVideosFromYoutube:
            var parameters = [String: Any]()
            parameters["key"] = "AIzaSyDxaYkWDFDDq5hkHTZoNmD41VF37eZ44WY"
            parameters["channelId"] = "UCblUw8mW0ymCdoh53PTK7uQ"
            parameters["part"] = "snippet,id"
            parameters["order"] = "date"
            parameters["maxResults"] = "20"
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        case .getVideosFromYoutubeNext(let nextPage):
            var parameters = [String: Any]()
            parameters["key"] = "AIzaSyDxaYkWDFDDq5hkHTZoNmD41VF37eZ44WY"
            parameters["channelId"] = "UCblUw8mW0ymCdoh53PTK7uQ"
            parameters["part"] = "snippet,id"
            parameters["order"] = "date"
            parameters["maxResults"] = "20"
            parameters["pageToken"] = nextPage
            return Task.requestParameters(parameters: parameters, encoding: encoding)
        default:
            return Task.requestPlain
        }
    }
}



