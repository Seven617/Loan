//
//  WeekNew.swift
//  WebTest
//
//  Created by 冷少白 on 2018/6/6.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct WeekNewIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : [weeknewdata]!
    
    
    
    init?(map: Map) {
    
    }
    
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct weeknewdata: Mappable {
    var id : Int!
    var name : String!
    var link : String!
    var logo : String!
    var comment : String!
    var maxAmount : AnyObject!
    var minAmount : AnyObject!
    
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        link <- map["link"]
        logo <- map["logo"]
        comment <- map["comment"]
        maxAmount <- map["maxAmount"]
        minAmount <- map["minAmount"]
    }
}

extension weeknewdata{
    static func request(completion: @escaping ([weeknewdata]?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.homeweeknew) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = WeekNewIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}


