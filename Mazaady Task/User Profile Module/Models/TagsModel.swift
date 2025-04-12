//
//  TagsModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation

struct TagsModel: Codable {
    var tags: [Tag]?
}

// MARK: - Tag
struct Tag: Codable {
    var id: Int?
    var name: String?
}
