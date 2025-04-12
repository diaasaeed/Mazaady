//
//  AdsModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
struct AdsModel: Codable ,Equatable{
    var advertisements: [Advertisement]?
}

// MARK: - Advertisement
struct Advertisement: Codable,Equatable {
    var id: Int?
    var image: String?
}
