//
//  NetworkClient.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Foundation
import Moya

final class NetworkClient: Client {

    let transport: Transport
    
    init(transport: Transport) {
        self.transport = transport
    }

    func performRequest<T>(api: APIEndpoint, decodeTo: T.Type, retryCount: Int = 3,  completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        transport.send(endPoint: api) { result in
            switch result {
            case .success((let data, let response)):
                
//                print(response)

                
                print(String(decoding: data, as: UTF8.self))
                completion(self.convert(to: T.self, using: data, and: response))
                
            case .failure(let error):
                if let httpResponse = error as? HTTPURLResponse, httpResponse.statusCode == 403 {
                    print("🚨 403 Forbidden - Token might be expired. Attempting refresh...")
                        // Start refresh process
                        if  retryCount > 0 {
                            print("🔄 Token refreshed! Retrying API call...")
                            self.performRequest(api: api, decodeTo: decodeTo, retryCount: retryCount - 1, completion: completion)
                    }
                    
                    
                }
                if(error.localizedDescription == "URLSessionTask failed with error: The Internet connection appears to be offline."){
                    completion(.failure(APIError.otherError(message: "thereAreNoInternetConnection")))
                } else if error.localizedDescription == "URLSessionTask failed with error: The request timed out." {
                    completion(.failure(APIError.requestTimeOut))
                } else if error.localizedDescription.contains("URLSessionTask failed with error: The network connection was lost.") {
                    completion(.failure(APIError.otherError(message: "networkConnectionLost")))
                } else {
                    completion(.failure(APIError.otherError(message: error.localizedDescription)))
                }
            }
        }
    }
    
    func performRequest(api: APIEndpoint, completion: @escaping (Result<Data, APIError>) -> Void) {
        transport.send(endPoint: api) { result in
            switch result {
            case .success((let data, let response)):
//                if let headerFields = response.allHeaderFields as? [String: String] {
//                    let url = api.baseURL
//                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
//                }
                completion(self.handle(data: data, response: response))
            case .failure(let error):
                if(error.localizedDescription == "URLSessionTask failed with error: The Internet connection appears to be offline."){
                    completion(.failure(APIError.otherError(message: "There are no Internet connection")))
                } else if error.localizedDescription == "URLSessionTask failed with error: The request timed out." {
                    completion(.failure(APIError.requestTimeOut))
                } else if error.localizedDescription.contains("URLSessionTask failed with error: The network connection was lost.") {
                    completion(.failure(APIError.otherError(message: "networkConnectionLost")))
                } else {
                    completion(.failure(APIError.otherError(message: error.localizedDescription)))
                }
            }
        }
    }
    
    let jsonDecoder = JSONDecoder()
    func convert<JsonType: Decodable>(to: JsonType.Type, using data: Data, and response: HTTPURLResponse) -> Result<JsonType, APIError> {
        switch handle(data: data, response: response) {
        case let .success(data):
            return decode(data, to: JsonType.self)
        case let .failure(error):
            return .failure(error)
        }
    }

    func handle(data: Data, response: HTTPURLResponse) -> Result<Data, APIError> {
        switch response.statusCode {
        case 200...299:
            return .success(data)
        case 401:
            return .failure(.notAuthorized)
        case 403:
            return .failure(.forbiddenError)
        case 404:
            return .failure(.notFoundError)
        case 400...499:
            return decodeError(error: BackendErrors.self, from: data, response: response)
        case 504:
            return .failure(.requestTimeOut)
        case 500...:
            return decodeError(error: BackendError.self, from: data, response: response)
        default:
            return dumpError(data: data, response: response)
        }
    }
    
    private func decode<JsonObject: Decodable>(_ data: Data, to: JsonObject.Type) -> Result<JsonObject, APIError> {
        do {
            jsonDecoder.keyDecodingStrategy = .useDefaultKeys
            return .success(try jsonDecoder.decode(JsonObject.self, from: data))
        }
        catch {
            print("decode Error = \(error)")
            return .failure(.otherError(message: error.localizedDescription))
        }
    }
    
    private func decodeError<Err: Decodable>(
        error: Err.Type,
        from data: Data,
        response: HTTPURLResponse
    ) -> Result<Data, APIError> {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        if let backendError = try? jsonDecoder.decode(BackendErrors.self, from: data) {
            return .failure(.backendError(backendError))
        } else {
            return .failure(APIError.otherError(message: "generalError"))
        }
    }

    // TODO: This is helpful while developing, should be changed to more user friendly message later
    private func dumpError(data: Data, response: HTTPURLResponse) -> Result<Data, APIError> {
        let dataContent = String(describing: String(data: data, encoding: String.Encoding.utf8))
        return .failure(.otherError(message: "Status Code: \(response.statusCode)\nData: \(dataContent)"))
    }

}

extension String {
    func addQueryParameters(queries: [URLQueryItem]) -> [String: Any] {
        var components = URLComponents()
        components.queryItems = queries
        return components.queryItems?.reduce(into: [String: Any]()) { result, item in
            result[item.name] = item.value
        } ?? [:]
    }
}

