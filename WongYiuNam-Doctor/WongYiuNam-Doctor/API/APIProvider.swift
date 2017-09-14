//
//  APIProvider.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//
import Moya
import Foundation

class APIProvider : MoyaProvider<API>{
    
    init(){
        let _endpointClosure = { (target: API) -> Endpoint<API> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            var headerFields = [String: String]()
            switch target {
            case .login:
                headerFields["X-App-Token"] = "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"
            default:
                headerFields["X-App-Token"] = "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"
            }
            return defaultEndpoint.adding(newHTTPHeaderFields: headerFields)
        }
        
        super.init(endpointClosure: _endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    func requestAPI(target: API, showProgressHUD: Bool = true) -> Observable<Result<Response, AnyError>> {
        return self.requestResonse(target: target, showProgressHUD: showProgressHUD)
            .map({ Result.success($0) })
            .catchError({ Observable.just(Result<Response, AnyError>.failure(AnyError($0))) })
        
        return self.request(target, completion: { (result) in
            
        })
    }
    
    
    private func requestResonse(target: API, showProgressHUD: Bool) -> Observable<Response> {

        
        return self
            .request(target)
            .filterSuccessfulStatusCodes()
            .catchError({ (error) -> Observable<Response> in
                var returnError = error
                if let error = error as? MoyaError {
                    switch error {
                    case .statusCode(let response):
                        if let error = try? response.mapObject(MyError.self) {
                            returnError = error
                        }
                    default:
                        break
                    }
                }
                throw returnError
            })
            .do(onNext: { _ in
                if showProgressHUD {
                    SVProgressHUD.dismiss()
                }
            }, onError: { _ in
                if showProgressHUD {
                    SVProgressHUD.dismiss()
                }
            })
    }
}

extension MoyaProvider {
    @discardableResult
    func request(_ target: API, autoRefreshToken: Bool, completion: @escaping Moya.Completion) -> Cancellable {
        
        let logoutMessage = "Your account has been logged in by another device.".__
        
        return CheapgoProvider.request(target) { result in
            switch result {
            case let .success(response):
                let baseResult: CGBaseResult? = Utils.mapOne(from: response)
                if baseResult?.error?.type == .tokenExpired {
                    Session.shareInstance.routeViewController.viewModel.refreshToken() { success in
                        if success {
                            CheapgoProvider.request(target, completion: completion)
                        } else {
                            Session.shareInstance.routeViewController.viewModel.logout(logoutMessage)
                        }
                    }
                } else if baseResult?.error?.type?.isFatalErrorNeedLogout() == true {
                    self.logout(baseResult: baseResult)
                } else {
                    completion(result)
                }
            case .failure:
                completion(result)
            }
        }
    }
}
