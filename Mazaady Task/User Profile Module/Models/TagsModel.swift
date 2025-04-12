//
//  TagsModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation

struct TagsModel: Codable , Equatable{
    var tags: [Tag]?
}

// MARK: - Tag
struct Tag: Codable , Equatable {
    var id: Int?
    var name: String?
}
