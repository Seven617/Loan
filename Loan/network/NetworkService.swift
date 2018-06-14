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
    case query(periodmax:Int?,periodmin:Int?,amountmax:Int?,amountmin:Int?)

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
        case .detil(let id):
            return "loanProductId is\(id)".utf8Encoded
        case .query(let periodmax,let periodmin,let amountmax,let amountmin):
            return "loanProduct query all\(periodmax! - periodmin! - amountmax! - amountmin!)".utf8Encoded
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
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    var baseURL: URL{
        let baseUrl = "http://kbd.kbfoo.com/freemarketApi"
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
