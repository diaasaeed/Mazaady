//
//  BackendError.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Foundation

struct BackendError: Decodable, Equatable {
    let code: Int?
    let field: String?
    let errorDetails: String?
    enum CodingKeys: CodingKey {
        case code
        case field
        case errorDetails
    }
    init(code: Int?, field: String?, errorDetails: String?) {
        self.code = code
        self.field = field
        self.errorDetails = errorDetails
    }
    
    func getErrorMessage() -> String {
        let errorMessage = ErrorMessages.shared.errors
        if let frErrorMessage = ErrorMessages.shared.fRErrors[self.errorDetails ?? ""] {
            return   frErrorMessage.en
        } else if let code = self.code, let errorMessage = ErrorMessages.shared.errors[String(code)] {
            return errorMessage.en
        } else {
            return errorDetails ?? "generalError"
        }
    }
}

struct BackendErrors: Decodable, Equatable {
    let errors: [BackendError]
}


struct ErrorMessages {
    static let shared = ErrorMessages()
    var errors: [String:BackendErrorMessage] = [:]
    var fRErrors: [String:BackendErrorMessage] = [:]
    
    private init() {
        self.loadErrors()
        self.loadFRErrors()
    }
    mutating func loadErrors() {
        if let errors: [BackendErrorMessage] = loadJson(filename: "ErrorsMessages") {
//            self.errors = errors.toDictionary({($0.Code, languageManager.isAppArabic() ? $0.Ar : $0.En)
//            })
            self.errors = errors.toDictionary({($0.code, $0)
            })
        } else {
            print("-- Error loading errors file")
        }
    }
    
    mutating func loadFRErrors() {
        if let errors: [BackendErrorMessage] = loadJson(filename: "FR_Error_messaging") {
//            self.fRErrors = errors.toDictionary({($0.Code, languageManager.isAppArabic() ? $0.Ar : $0.En)})
            self.fRErrors = errors.toDictionary({($0.code, $0)})
        } else {
            print("-- Error loading errors file")
        }
    }
}

struct BackendErrorMessage: Codable {
    let code: String
    let en: String
    let ar: String
}
extension Sequence {
    public func toDictionary<K: Hashable, V>(_ selector: (Iterator.Element) throws -> (K, V)?) rethrows -> [K: V] {
        var dict = [K: V]()
        for element in self {
            if let (key, value) = try selector(element) {
                dict[key] = value
            }
        }
        return dict
    }
}
