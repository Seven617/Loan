//
//  NetworkService.swift
//  WebTest
//
//  Created by 冷少白 on 2018/6/6.
//  Copyright © 2018年 kbfoo. All rights reserved.
//

import Foundation
import Moya

enum NetworkService{
    case homebanner
    case homeweeknew
    case homeradio
    case homeweekhot
    case homeweekspeed
    case detil(id: Int)
    case query(periodmax:Int,periodmin:Int,amountmax:Int,amountmin:Int)
    case login(name:String,code:String)
    case authCode(mobile:String)
    case checktoken(token:String,userId:String)
    case userinfo(userId:String)
    case infosave(userId:String,name:String,idCard:String)
}
extension NetworkService: TargetType{
    var sampleData: Data {
        switch self {
        case .homebanner:
            return "homebanner".utf8Encoded
        case .homeweeknew:
            return "homeweeknew".utf8Encoded
        case .homeweekhot:
            return "homeweekhot".utf8Encoded
        case .homeweekspeed:
            return "homeweekspeed".utf8Encoded
        case .homeradio:
            return "homeradio".utf8Encoded
        case .detil:
            return "loanProductId".utf8Encoded
        case .query:
            return "loanProduct query all".utf8Encoded
        case .login:
            return "login".utf8Encoded
        case .authCode:
            return "authCode".utf8Encoded
        case .checktoken:
            return "checktoken".utf8Encoded
        case .userinfo:
            return "userinfo".utf8Encoded
        case .infosave:
            return "infosave".utf8Encoded
        }
        
        
    }
    
    var task: Task {
        switch self {
        case .homebanner:
            return .requestPlain
        case .homeweeknew:
            return .requestPlain
        case .homeweekhot:
            return .requestPlain
        case .homeweekspeed:
            return .requestPlain
        case .homeradio:
            return .requestPlain
        case .detil(let id):
            return .requestParameters(parameters: ["loanProductId" : id], encoding: URLEncoding.queryString)
        case .query(let periodmax,let periodmin,let amountmax,let amountmin):
            return .requestParameters(parameters: ["loanPeriodMax":periodmax as Any,"loanPeriodMin":periodmin as Any,"loanAmountMax":amountmax as Any,"loanAmountMin":amountmin as Any],encoding: URLEncoding.queryString)
        case .login(let mobile, let code):
            return .requestParameters(parameters: ["mobile" : mobile,"code":code], encoding: URLEncoding.queryString)
        case .authCode(let mobile):
            return .requestParameters(parameters: ["mobile" : mobile], encoding: URLEncoding.queryString)
        case .checktoken(let token,let userId ):
            return .requestParameters(parameters: ["token" : token,"userId":userId], encoding: URLEncoding.queryString)
        case .userinfo(let userId):
            return .requestParameters(parameters: ["userId":userId], encoding: URLEncoding.queryString)
        case .infosave(let userId, let name, let idCard):
            return .requestParameters(parameters: ["userId":userId,"name":name,"idCard":idCard], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    var baseURL: URL{
        let baseUrl = "http://kbd.kbfoo.com/freemarketApi"
//        let baseUrl = "http://192.168.2.111:8380/freemarket-web"
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .homebanner:
            return "/home/adPosition"
        case .homeweeknew:
            return "/loanProduct/weekNew/home"
        case .homeweekhot:
            return "/loanProduct/weekHot/home"
        case .homeweekspeed:
            return "/loanProduct/topSpeed"
        case .homeradio:
            return "/menu/loan/user/list"
        case .detil:
            return "/loanProduct/detail"
        case .query:
            return "/loanProduct/query"
        case .login:
            return "/user/logon"
        case .authCode:
            return "/user/authCode"
        case .checktoken:
            return "/user/token/validate"
        case .userinfo:
            return "/user/info"
        case .infosave:
            return "/user/info/save"
        }
    }
    var method: Moya.Method {
        switch self {
        case .homebanner:
            return .get
        case .homeweeknew:
            return .get
        case .homeweekhot:
            return .get
        case .homeweekspeed:
            return .get
        case .homeradio:
            return .get
        case .detil:
            return .get
        case .query:
            return .get
        case .login:
            return .post
        case .authCode:
            return .post
        case .checktoken:
            return .post
        case .userinfo:
            return .post
        case .infosave:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .homebanner:
            return nil
        case .homeweeknew:
            return nil
        case .homeweekhot:
            return nil
        case .homeweekspeed:
            return nil
        case .homeradio:
            return nil
        case .detil:
            return nil
        case .query:
            return nil
        case .login:
            return nil
        case .authCode:
            return nil
        case .checktoken:
            return nil
        case .userinfo:
            return nil
        case .infosave:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .homebanner:
            return URLEncoding.default
        case .homeweeknew:
            return URLEncoding.default
        case .homeweekhot:
            return URLEncoding.default
        case .homeweekspeed:
            return URLEncoding.default
        case .homeradio:
            return URLEncoding.default
        case .detil:
            return URLEncoding.default
        case .query:
            return URLEncoding.default
        case .login:
            return URLEncoding.default
        case .authCode:
            return URLEncoding.default
        case .checktoken:
            return URLEncoding.default
        case .userinfo:
            return URLEncoding.default
        case .infosave:
            return URLEncoding.default
        }
        
    }
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

