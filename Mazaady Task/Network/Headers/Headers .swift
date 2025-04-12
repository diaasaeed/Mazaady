//
//  Heder.swift
//  Runner
//
//  Created by Diaa saeed on 14/05/2024.
//

import Foundation
import Alamofire




class HeadersRequest {
    static let shared = HeadersRequest()
    func getHeaders() -> [String: String] {
        var httpHeaders = [String: String]()
        
//        if type == .normal {
//            httpHeaders = [
//                "PLATFORM":"ios",
//                "Accept":"application/json",
//                "Accept-Language":"en",
//                "DEVICE_ID":UserDefaultModel.shared.getUUID(),
//                "DEVICE_TOKEN":"",
//                "Content-Type":"application/json",
//                "AppVersion":"10.0.1",
//                "APP_VERSION":"10.0.1",
//                "channel":"mobileapp",
//                "TGDeviceId":UserDefaultModel.shared.getTGDeviceId(),
//                "TG-Token":UserDefaultModel.shared.getTGToken(),
//                "TG-Refresh-Token":UserDefaultModel.shared.getTGRefreshToken(),
//                "Access-Token":UserDefaultModel.shared.getAccessToken(),
//                "Authorization": "Bearer \(UserDefaultModel.shared.getUserApiToken())"
//            ]
//        } else if type == .refreshToken {
//            httpHeaders = [
//                "PLATFORM":"ios",
//                "content-type":"application/json",
//                "Accept":"application/json",
//                "Accept-Language":"en",
//                "DEVICE_ID":UserDefaultModel.shared.getUUID(),
//                "DEVICE_TOKEN":"",
//                "Content-Type":"application/json",
//                "AppVersion":"10.0.1",
//                "APP_VERSION":"10.0.1",
//                "channel":"mobileapp",
//                "TGDeviceId":UserDefaultModel.shared.getTGDeviceId(),
//                "TG-Token":UserDefaultModel.shared.getTGToken(),
//                "TG-Refresh-Token":UserDefaultModel.shared.getTGRefreshToken(),
//                "Access-Token":UserDefaultModel.shared.getAccessToken(),
////                "Authorization": "Bearer \(UserDefaultModel.shared.getUserApiToken())",
//                "deadToken": UserDefaultModel.shared.getUserApiToken()
//            ]
//        }
//        
        return httpHeaders
    }
}
