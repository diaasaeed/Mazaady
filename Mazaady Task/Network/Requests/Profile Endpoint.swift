//
//  Profile Requests.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
import Moya

enum ProfileAPIEndPoint {
    case advertisements
    case tags
    case userInfo
    case products
}

extension ProfileAPIEndPoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: EnviromentConfigurations.baseUrl.rawValue)!
    }

    var path: String {
        switch self {
        case .advertisements:
            return "advertisements"
        case .tags:
           return "tags"
        case .userInfo:
            return "user"
        case .products:
            return "products"
       
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case  .advertisements,  .tags  , .userInfo , .products:
            return .get
            
        }
    }
    
    var task: Task {
        switch self {
        case .advertisements , .tags , .userInfo , .products :
            return .requestPlain
            

            
        default:
            return .requestPlain
        }
    }

    var headers: [String : String] {
        switch self {
        case .advertisements,  .tags  , .userInfo , .products :
            return HeadersRequest.shared.getHeaders()
        }
    }
}
