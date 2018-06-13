//
//  Banner.swift
//  WebTest
//
//  Created by 冷少白 on 2018/6/7.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct BannerIndexResponse: Mappable {
    var errorMsg : String?
    var code : Int!
    var timestamp : AnyObject!
    var data : bannerdata!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
        data <- map["data"]
    }
}

struct bannerdata: Mappable {
    var bannerList : [bannerList]!
    var classifyList : [classifyList]!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        bannerList <- map["bannerList"]
        classifyList <- map["classifyList"]
    }
}

struct bannerList: Mappable {
    var id : Int!
    var targetType: Int!
    var title : String!
    var image : String!
    var targetContent : String!
    
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        targetType <- map["targetType"]
        targetContent <- map["targetContent"]
    }
}


struct classifyList: Mappable {
    var id : Int!
    var title : String!
    var image : String!
    var targetType: Int!
    var targetContent : String!
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
        targetType <- map["targetType"]
        targetContent <- map["targetContent"]
    }
}

extension bannerdata{
    static func request(completion: @escaping (bannerdata?) -> Void){
        let provider = MoyaProvider<NetworkService>()
        provider.request(.homebanner) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON() as! [String: Any]
                if let jsonResponse = BannerIndexResponse(JSON: json){
                    completion(jsonResponse.data)
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}
