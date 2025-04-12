//
//  Transport.swift
//  LandRegistry
//
//  Created by Taha Hussein.
//

import Foundation

protocol Transport {
    func send(endPoint: APIEndpoint, completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ())
}
