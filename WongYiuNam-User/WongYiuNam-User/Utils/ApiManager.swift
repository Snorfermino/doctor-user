//
//  ApiManager.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import FacebookCore

class ApiManager {
    
    static var videoYoutubeNextPage: String?
    static var videoYoutubeCanNextPage: Bool = true
    static var loadPostFBNextPage: String?
    
    static func getDoctors(page: Int, completion: @escaping (([Doctor]) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.doctors(page: page)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let doctorsResponse = try response.mapObject(PagingResponse<Doctor>.self)
                    if let doctors = doctorsResponse.data {
                        completion(doctors)
                    } else {
                        completion([])
                    }
                } catch {
                    completion([])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping ((User?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.login(email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let userResponse = try response.mapObject(User.self)
                    completion(mn , nil)
                } catch {
                    do {
                        let err = try response.mapJSON() as! [String]
                        completion(nil, err[0])
                    } catch {
                        completion(nil, "Error login")
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func getPaymentToken(completion: @escaping ((String?, String?) -> Void)){
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.getPaymentToken) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
//                    let userResponse = try response.mapObject(User.self)
//                    completion(userResponse, nil)
                } catch {
                    do {
                        let err = try response.mapJSON() as! [String]
                        completion(nil, err[0])
                    } catch {
                        completion(nil, "Error login")
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    static func loginViaFacebook(email: String, name: String, id: String, completion: @escaping ((User?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.loginViaFacebook(email: email, name: name, fbId: id)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let userResponse = try response.mapObject(User.self)
                    completion(userResponse, nil)
                } catch {
                    do {
                        let err = try response.mapJSON() as! [String]
                        completion(nil, err[0])
                    } catch {
                        completion(nil, "Error login")
                    }
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func askaQuestion(question: Question, completion:  (() -> Void)?) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.askaQuestion(question: question)) { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func register(name: String, email: String, password: String, completion: @escaping ((User?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.register(name: name, email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                if(response.statusCode == 200) {
                    do {
                        let userResponse = try response.mapObject(User.self)
                        completion(userResponse, nil)
                    } catch {
                        //
                    }
                } else {
                    completion(nil, self.parseError(response: response))
                }
                completion(nil, nil)
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func changePassword(oldPassword: String, newPassword: String, completion: @escaping ((String, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.changePassword(oldPassword: oldPassword, newPassword: newPassword)) { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func updateUserProfile(user: User, completion: @escaping ((String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.updateUserProfile(user: user)) { (result) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getPostsFromFanpageFacebook(completion: @escaping (([PostFB]?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        var target: MyServerAPI!
        if let loadPostFBNextPage = loadPostFBNextPage {
            target = .getPostsFromFanpageFacebookNext(nextPage: loadPostFBNextPage)
        } else {
            target = .getPostsFromFanpageFacebook
        }
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let responsePaging = try response.mapObject(PagingResponseFB<PostFB>.self)
                    loadPostFBNextPage = responsePaging.nextPage
                    let data = responsePaging.data
                    completion(data, nil)
                } catch {
                    completion(nil, "Error Parse Json")
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func getVideosFromYoutubeChannel(completion: @escaping (([VideoYT]?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        
        var target: MyServerAPI!
        if let videoYoutubeNextPage = videoYoutubeNextPage {
            target = .getVideosFromYoutubeNext(nextPage: videoYoutubeNextPage)
        } else {
            target = .getVideosFromYoutube
        }
        if(videoYoutubeCanNextPage == false) {
            completion(nil, nil)
            return
        }
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let responsePaging = try response.mapObject(PagingResponseYT<VideoYT>.self)
                    videoYoutubeNextPage = responsePaging.nextPageToken
                    let data = responsePaging.data
                    if(data!.count < 20) {
                        videoYoutubeCanNextPage = false
                    }
                    completion(data, nil)
                } catch {
                    completion(nil, "Error Parse Json")
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func getFavoritesDoctors(completion: @escaping (([Doctor]?, String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.favouritesDoctors) { (result) in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let data = try response.mapArray(Doctor.self)
                    completion(data, nil)
                } catch {
                    completion(nil, "Error Parse Json")
                }
            case .failure(let error):
                print(error)
                completion(nil, error.errorDescription)
            }
        }
    }
    
    static func saveFavoritesDoctors(doctorId: Int, completion: @escaping ((String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.saveFavoritesDoctor(doctorId: doctorId)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error.errorDescription)
            }
        }
    }
    
    static func deleteFavoritesDoctors(doctorId: Int, completion: @escaping ((String?) -> Void)) {
        let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(.deleteFavoritesDoctor(doctorId: doctorId)) { (result) in
            switch result {
            case .success(let response):
                print(response)
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error.errorDescription)
            }
        }
    }
    
    static func parseError(response: Response) -> String? {
        do {
            let errorResponse = try response.mapObject(ErrorResponse.self)
            return errorResponse.msg
        } catch {
            return nil
        }
    
    }
}

