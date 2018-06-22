//
//  AuthCode.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/19.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct AuthCodeIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : [authdata]!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct authdata: Mappable {
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        
    }
}


extension authdata{
    static func request(mobile:String,completion: @escaping ([authdata]?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.authCode(mobile:mobile)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = AuthCodeIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
