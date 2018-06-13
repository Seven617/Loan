//
//  WeekSpeed.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/11.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct WeekSpeedIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : [weekspeeddata]!
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct weekspeeddata: Mappable {
    var id : Int!
    var name : String!
    var link : String!
    var logo : String!
    var comment : String!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        link <- map["link"]
        logo <- map["logo"]
        comment <- map["comment"]
    }
}

extension weekspeeddata{
    static func request(completion: @escaping ([weekspeeddata]?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.homeweekspeed) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = WeekSpeedIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
