//
//  EnviromentConfigurations.swift
//  RER
//
//  Created by Taha Hussein.
//

import Foundation

enum EnviromentConfigurations: String {
    case baseUrl = "https://stagingapi.mazaady.com/api/interview-tasks/"

    // MARK: - Plist values
    var value: String {
        get {
            return Bundle.main.infoDictionary?[self.rawValue] as? String ?? "Default Value"
        }
    }
}


