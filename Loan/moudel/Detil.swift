//
//  Detil.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/7.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct DetilIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : detildata!
    
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct detildata:Mappable {
    var id : Int!
    var name : String!
    var link : String!
    var logo : String!
    //关键提示
    var comment : String!
    //所需材料
    var otherInfo : String!
    // 申请条件
    var applyCondition : String!
    //产品介绍
    var description : String!
    var maxAmount : AnyObject!
    var minAmount : AnyObject!
    var minRate : AnyObject!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        link <- map["link"]
        logo <- map["logo"]
        comment <- map["comment"]
        otherInfo <- map["otherInfo"]
        applyCondition <- map["applyCondition"]
        description <- map["description"]
        maxAmount <- map["maxAmount"]
        minAmount <- map["minAmount"]
        minRate <- map["minRate"]
    }
}

extension detildata{
    static func request(id: Int, completion: @escaping (detildata?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.detil(id: id)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = DetilIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}

