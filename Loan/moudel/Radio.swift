//
//  Radio.swift
//  WebTest
//
//  Created by 冷少白 on 2018/6/6.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct RadioIndexResponse: Mappable {
    
    var errorMsg : String?
    var code : Int!
    var timestamp : AnyObject!
    var data : radiodata!
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
    
}

struct radiodata: Mappable {
    var list : [radiolist]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
    }
}

struct radiolist: Mappable {
    var productId : Int!
    var descriptionBoard : String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        productId <- map["productId"]
        descriptionBoard <- map["descriptionBoard"]
    }
}

extension radiodata{
    static func request(completion: @escaping (radiodata?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.homeradio) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = RadioIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
