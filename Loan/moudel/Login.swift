//
//  Login.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/19.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct LoginIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : logindata!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct logindata: Mappable {
    var userId:AnyObject!
    var token:AnyObject!
    var nextStep:Int!
    var authPass:Bool!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        userId <- map["userId"]
        token <- map["token"]
        nextStep <- map["nextStep"]
        authPass <- map["authPass"]
    }
}

extension logindata{
    static func request(name:String,code:String,completion: @escaping (logindata?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.login(name: name, code: code)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = LoginIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}

//获取是否登录成功的code作为判断
extension LoginIndexResponse{
    static func request(name:String,code:String,completion: @escaping (Int?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.login(name: name, code: code)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = LoginIndexResponse(JSON: json){
                    completion(jsonResponse.code)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
