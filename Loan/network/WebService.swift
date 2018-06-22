//
//  WebService.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/20.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Alamofire
class WebService {
    
    // set false when release
    static var verbose: Bool = true
    
    // session manager
    static func manager() -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 15 // timeout
        let manager = Alamofire.SessionManager(configuration: configuration)
        manager.adapter = CustomRequestAdapter()
        return manager
    }
    
    // request adpater to add default http header parameter
    private class CustomRequestAdapter: RequestAdapter {
        public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
            var urlRequest = urlRequest
            urlRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            return urlRequest
        }
    }
    
    // response result type
    enum Result {
        case success(JSONDecoder)
        case failure(String)
    }
}
