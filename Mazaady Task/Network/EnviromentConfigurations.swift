//
//  EnviromentConfigurations.swift
//  RER
//
//  Created by Taha Hussein.
//

import Foundation

enum EnviromentConfigurations  {
    
    static var baseUrl: String{
        do{
            return try BuildConfiguration.value(for: "BASE_URL")
        }catch{
            fatalError(error.localizedDescription)
        }
    }
//    case baseUrl {
//        do{
//            rturn
//        }
//    } // = "https://stagingapi.mazaady.com/api/interview-tasks/"

//    BuildConfiguration.value(for: "BASE_RL")
    // MARK: - Plist values
//    var value: String {
//        get {
//            return Bundle.main.infoDictionary?[self.rawValue] as? String ?? "Default Value"
//        }
//    }
}



private enum BuildConfiguration {
    enum Error: Swift.Error {
        case missingkey, invalidValue
    }
    static func value<T>(for key: String) throws-> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingkey
        }
        switch object {
        case let string as String:
            guard let value = T(string) else {fallthrough}
            return value
        default:
            throw Error.invalidValue
        }
    }
}
