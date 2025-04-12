//
//  JsonDecoder.swift
//  RER
//
//  Created by Taha Hussein.
//

import Foundation


func loadJson<T:Codable>(filename fileName: String) -> T? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return  try decoder.decode(T.self, from: data)
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}


class JsonUtils {
    
    static func encode<T: Codable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(object)
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

@propertyWrapper
struct DecodableBool {
    var wrappedValue = false
}

extension DecodableBool: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Bool.self)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: DecodableBool.Type,
                forKey key: Key) throws -> DecodableBool {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}
