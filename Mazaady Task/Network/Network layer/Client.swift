//
//  Client.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Foundation
    
protocol Client {
    func performRequest<T: Decodable>(
        api: APIEndpoint,
        decodeTo: T.Type,
        retryCount: Int ,
        completion: @escaping (Result<T, APIError>) -> Void
    )
    func performRequest(
        api: APIEndpoint,
        completion: @escaping (Result<Data, APIError>) -> Void
    )
}

extension Client {
    func performRequest<T: Decodable>(
        api: APIEndpoint,
        decodeTo: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        performRequest(api: api, decodeTo: decodeTo, retryCount: 3, completion: completion)
    }
}


protocol HasClient {
    var client: Client { get }
}
