//
//  MoyaProvider+Transport.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Moya
import Foundation

extension MoyaProvider: Transport where Target == MoyaAPI {
    func send(endPoint: APIEndpoint, completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ()) {
        // Define the Moya task based on the APIEndpoint's task
        let moyaTask: Moya.Task
        switch endPoint.task {
        case .requestJSONEncodable(let encodable):
            moyaTask = .requestJSONEncodable(encodable)
        case .requestPlain:
            moyaTask = .requestPlain
        case .requestData(let data):
            moyaTask = .requestData(data)
        case .requestParameters(parameters: let params, encoding: let encoding):
            moyaTask = .requestParameters(parameters: params, encoding: encoding)
        case .uploadMultipart(let multipart):
            moyaTask = .uploadMultipart(multipart)
        case .uploadCompositeMultipart(let multipart, let urlParameters):
            moyaTask = .uploadCompositeMultipart(multipart, urlParameters: urlParameters)
        case .requestCompositeData(let bodyData, let urlParameters):
            moyaTask = .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters)
        }
        
        // Create the MoyaAPI instance
        let api = MoyaAPI(baseURL: endPoint.baseURL,
                          path: endPoint.path,
                          method: Moya.Method(rawValue: endPoint.method.rawValue),
                          sampleData: Data(),
                          task: moyaTask,
                          headers: endPoint.headers)
        
        // Perform the request
        self.request(api) { moyaResult in
            switch moyaResult {
            case .success(let moyaResponse):
                completion(.success((data: moyaResponse.data, response: moyaResponse.response!)))
            case .failure(let moyaError):
                completion(.failure(moyaError as Error))
            }
        }
    }
}

struct MoyaAPI: TargetType {
    let baseURL: URL
    
    let path: String
    
    let method: Moya.Method
    
    let sampleData: Data
    
    let task: Moya.Task
    
    let headers: [String : String]?
}
