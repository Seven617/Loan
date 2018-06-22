//
//  UserInfo.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/20.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

struct UserInfoIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : userinfodata!
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}
struct userinfodata: Mappable {
    var mobile: String!
    var name: String!
    var idCard: String!
    var loanAmountMin: String!
    var loanAmountMax: String!
    var loanPeriodMin: String!
    var loanPeriodMax: String!
    var locationCity: String!
    var locationProvince: String!
    var locationCityName: String!
    var career: Int!
    var otherInfo: String!
    var status: Int!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
         mobile <- map["mobile"]
         name <- map["name"]
         idCard <- map["idCard"]
         loanAmountMin <- map["loanAmountMin"]
         loanAmountMax <- map["loanAmountMax"]
         loanPeriodMin <- map["loanPeriodMin"]
         loanPeriodMax <- map["loanPeriodMax"]
         locationCity <- map["locationCity"]
         locationProvince <- map["locationProvince"]
         locationCityName <- map["locationCityName"]
         career <- map["career"]
         otherInfo <- map["otherInfo"]
         status <- map["status"]
    }
}
extension userinfodata{
    static func request(userId:String,completion: @escaping (userinfodata?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.userinfo(userId:userId)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = UserInfoIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}

