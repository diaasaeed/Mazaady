//
//  ProductModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
struct ProductModel: Codable , Equatable {
    var id: Int?
    var name: String?
    var image: String?
    var price: Int?
    var currency: String?
    var offer: Int?
    var endDate: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, image, price, currency, offer
        case endDate = "end_date"
    }
}

