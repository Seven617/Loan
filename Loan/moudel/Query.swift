//
//  Query.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/10.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct  QueryIndexResponse: Mappable{
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : [querydata]!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct querydata: Mappable {
    var id : Int!
    var name : String!
    var link : String!
    var logo : String!
    var maxAmount : AnyObject!
    var minAmount : AnyObject!
    var loanTime : AnyObject!
    var loanTimeUnit : AnyObject!
    var minRate : AnyObject!
    var rateUnit : AnyObject!
    var comment : String!
    var jointWay : AnyObject!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        link <- map["link"]
        logo <- map["logo"]
        maxAmount <- map["maxAmount"]
        minAmount <- map["minAmount"]
        loanTime <- map["loanTime"]
        loanTimeUnit <- map["loanTimeUnit"]
        minRate <- map["minRate"]
        rateUnit <- map["rateUnit"]
        comment <- map["comment"]
        jointWay <- map["jointWay"]
    }
}

extension querydata{
    static func request(periodmax:Int?,periodmin:Int?,amountmax:Int?,amountmin:Int?,completion: @escaping ([querydata]?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.query(periodmax: periodmax, periodmin: periodmin, amountmax: amountmax, amountmin: amountmin)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = QueryIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
