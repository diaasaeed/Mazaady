//
//  GenricAPIResponse.swift
//  RER
//
//  Created by Taha Hussein.
//

import Foundation

struct GenericAPIResponse<T: Codable>: Codable {
    let result: Response<T>?
}

struct Response<T: Codable>: Codable {
    let data: T?
}

