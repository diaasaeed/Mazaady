//
//  JSONParser.swift
//  Runner
//
//  Created by Diaa saeed on 23/02/2025.
//

import Foundation
class JSONParser {
    /// Convert a JSON string to a model
    static func decode<T: Decodable>(_ jsonString: String, to type: T.Type) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: jsonData)
        } catch {
            print("❌ Decoding Error: \(error)")
            return nil
        }
    }
    
    /// Convert a model to a JSON string
    static func encode<T: Encodable>(_ model: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(model)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("❌ Encoding Error: \(error)")
            return nil
        }
    }
}
