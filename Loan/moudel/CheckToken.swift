//
//  CheckToken.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/19.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

struct CheckTokenIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : checktokendata!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}
struct checktokendata: Mappable {
    var userId:String!
    var token:String!
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

//获取是否登录的code作为判断
extension CheckTokenIndexResponse{
    static func request(token:String,userId:String,completion: @escaping (Int?) -> Void){
 
        
        let provider = MoyaProvider<NetworkService>(manager: WebService.manager())
        provider.request(.checktoken(token:token,userId:userId)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = CheckTokenIndexResponse(JSON: json){
                    completion(jsonResponse.code)
                    print(jsonResponse.errorMsg)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}


