//
//  InfoSave.swift
//  Loan
//
//  Created by 冷少白 on 2018/6/21.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

struct InfoSaveIndexResponse: Mappable {
    var errorMsg : String!
    var code : Int!
    var timestamp : AnyObject!
    var data : AnyObject!
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        errorMsg <- map["errorMsg"]
        code <- map["code"]
        timestamp <- map["timestamp"]
    }
}

//获取是否登录的code作为判断
extension InfoSaveIndexResponse{
    static func request(userId:String,name:String,idCard:String,completion: @escaping (Int?) -> Void){
        let provider = MoyaProvider<NetworkService>(manager: WebService.manager())
        provider.request(.infosave(userId:userId,name:name,idCard:idCard)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let json = try! moyaResponse.mapJSON()as![String:Any]
                if let jsonResponse = InfoSaveIndexResponse(JSON: json){
                    completion(jsonResponse.code)
                    if jsonResponse.errorMsg != nil{
//                        SYIToast.alert(withTitleBottom: "信息保存失败:\(jsonResponse.errorMsg!)")
                    }
                }
            case .failure:
                print("网络错误")
                completion(nil)
            }
        }
    }
}

