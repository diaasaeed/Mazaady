//
//  APIError.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//
import Foundation

enum APIError: LocalizedError, Equatable {
    case backendError(BackendErrors)
    case forbiddenError
    case notFoundError
    case notAuthorized
    case noInternet
    case requestTimeOut
    case otherError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .backendError(let model):
            let message = model.errors.first?.getErrorMessage()
            return message ?? "generalError"
        case .forbiddenError:
            return "forbidden"
        case .notFoundError:
            return "notFound"
        case .notAuthorized:
            return "yourSessionHasExpired"
        case .otherError(let message):
            return message
        case .noInternet:
            return "NoInternet"
        case .requestTimeOut:
            return "connectionError"
        }
    }
}
