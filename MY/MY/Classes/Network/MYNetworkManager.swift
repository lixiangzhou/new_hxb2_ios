//
//  MYNetworkManager.swift
//  MY
//
//  Created by lxz on 2018/7/25.
//  Copyright © 2018年 lixiangzhou. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ReactiveSwift
import Result

typealias HXBRequestParam = Parameters
typealias HXBRequestHeader = HTTPHeaders
typealias HXBResponseObject = [String: Any]
typealias HXBHttpMethod = HTTPMethod
typealias HXBRequestResult = (Bool, MYRequestApi)
typealias HXBRequestConfigClosrue = (MYRequestApi) -> ()

class HXBNetworkManager {
    /// 单例
    static let shared = HXBNetworkManager()
    
    /// 参数编码
    private let encoding = URLEncoding.default
    /// session
    private let sessionManager = SessionManager.default
    
    private init() { }
    
    @discardableResult
    func send(requestApi: MYRequestApi) ->  SignalProducer<HXBRequestResult, NoError> {
        return SignalProducer<HXBRequestResult, NoError> { [weak self] (observer, lifetime) in
            guard let url = self!.getUrl(requestApi: requestApi) else {
                requestApi.error = MYError.requestUrlNil
                observer.send(value: (false, requestApi))
                observer.sendCompleted()
                return
            }
            
            do {
                // 构建请求
                var originRequest = URLRequest(url: url)
                
                originRequest.httpMethod = requestApi.requestMethod.rawValue
                originRequest.timeoutInterval = requestApi.timeout
                originRequest.httpShouldHandleCookies = false
                originRequest.allHTTPHeaderFields = self!.getHeaderFields(requestApi: requestApi)
                
                // 请求参数编码
                let encodedRequest = try self!.encoding.encode(originRequest, with: requestApi.params)
                requestApi.request = encodedRequest
                
                // HUD
                requestApi.showProgress()
                MYNetActivityManager.sendRequest()
                
                if requestApi.responseSerializeType == .json {
                    // 发送请求
                    self!.sessionManager.request(requestApi.request!).responseJSON { responseData in
                        // HUD
                        requestApi.hideProgress()
                        MYNetActivityManager.finishRequest()
                        
                        requestApi.httpResponse = responseData.response
                        
                        if responseData.result.isSuccess {
                            //                            log.info(responseData.result.value!)
                            requestApi.responseObject = responseData.result.value as? HXBResponseObject
                            
                            self!.successProcess(requestApi: requestApi, withObserver: observer)
                        } else {
                            log.error(responseData.error!)
                            requestApi.error = responseData.error
                            
                            self!.errorProcess(requestApi: requestApi, withObserver: observer)
                        }
                    }
                } else if requestApi.responseSerializeType == .data {
                    self!.sessionManager.request(requestApi.request!).responseData(completionHandler: { responseData in
                        // HUD
                        requestApi.hideProgress()
                        MYNetActivityManager.finishRequest()
                        
                        requestApi.httpResponse = responseData.response
                        
                        if responseData.result.isSuccess {
                            //                            log.info(responseData.result.value!)
                            requestApi.responseData = responseData.result.value
                            
                            self!.successProcess(requestApi: requestApi, withObserver: observer)
                        } else {
                            log.error(responseData.error!)
                            requestApi.error = responseData.error
                            
                            self!.errorProcess(requestApi: requestApi, withObserver: observer)
                        }
                    })
                }
            } catch {
                requestApi.error = MYError.encodingFailed(error: error)
                observer.send(value: (false, requestApi))
                observer.sendCompleted()
            }
        }
    }
}


// MARK: - Public
extension HXBNetworkManager {
    static func request(url: String, params: HXBRequestParam? = nil, method: HXBHttpMethod = .get, responseSerializeType: MYRequestApi.HXBResponseSerializeType = .json, configRequstClosure: HXBRequestConfigClosrue? = nil) -> SignalProducer<HXBRequestResult, NoError> {
        let requestApi = MYRequestApi()
        requestApi.requestUrl = url
        requestApi.params = params
        requestApi.requestMethod = method
        requestApi.responseSerializeType = responseSerializeType
        configRequstClosure?(requestApi)
        return request(requestApi: requestApi)
    }
    
    static func request(requestApi: MYRequestApi) -> SignalProducer<HXBRequestResult, NoError> {
        return HXBNetworkManager.shared.send(requestApi: requestApi)
    }
}

// MARK: - Helper
extension HXBNetworkManager {
    fileprivate func getUrl(requestApi: MYRequestApi) -> URL? {
        guard let requestUrl = requestApi.requestUrl else {
            return nil
        }
        
        var urlString = ""
        if let baseUrl = requestApi.baseUrl {
            urlString = baseUrl + requestUrl
        } else {
            urlString = my.net.baseUrl + requestUrl
        }
        
        return URL(string: urlString)
    }
    
    fileprivate func getHeaderFields(requestApi: MYRequestApi) -> HXBRequestHeader {
        var baseHeaderFields = my.net.baseHeaderFields
        baseHeaderFields[my.net.tokenKey] = MYKeychain[my.keychain.token] ?? ""
        guard let headerFields = requestApi.requestHeaderFields else {
            return baseHeaderFields
        }
        for (key, value) in headerFields {
            baseHeaderFields[key] = value
        }
        return baseHeaderFields
    }
}

// MARK: - Result Process
extension HXBNetworkManager {
    fileprivate func errorProcess(requestApi: MYRequestApi, withObserver observer: Signal<HXBRequestResult, NoError>.Observer) {
        if requestApi.statusCode == my.code.tokenInvalid { // token 失效，重新请求 token，
            self.tokenRequest(completion: { isSuccess in
                if isSuccess {  // 成功后重新发送请求
                    self.send(requestApi: requestApi)
                } else {    // 失败就调用回调
                    loginObserver.send(value: nil)
                    observer.send(value: (false, requestApi))
                }
                observer.sendCompleted()
            })
        } else {
            if requestApi.statusCode == my.code.notLogin {
                loginObserver.send(value: nil)
            }
            observer.send(value: (false, requestApi))
            observer.sendCompleted()
        }
    }
    
    fileprivate func successProcess(requestApi: MYRequestApi, withObserver observer: Signal<HXBRequestResult, NoError>.Observer) {
        if requestApi.responseSerializeType == .json {
            let respObj = JSON(requestApi.responseObject!)
            if respObj.isSuccess {
                observer.send(value: (true, requestApi))
            } else {
                observer.send(value: (false, requestApi))
            }
            observer.sendCompleted()
        } else {
            observer.send(value: (true, requestApi))
            observer.sendCompleted()
        }
    }
}

// MARK: - Token & Single Login
extension HXBNetworkManager {
    fileprivate func tokenRequest(completion: @escaping (Bool) -> ()) {
        Alamofire.request(my.net.baseUrl + my.api.token).responseJSON { responseObject in
            if responseObject.result.isSuccess {
                let json = JSON(responseObject.result.value as! HXBResponseObject)
                let token = json["data"]["token"].stringValue
                MYKeychain[my.keychain.token] = token
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

