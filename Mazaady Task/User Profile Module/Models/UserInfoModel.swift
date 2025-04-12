//
//  UserInfoModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
struct UserInfoModel: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var userName: String?
    var followingCount, followersCount: Int?
    var countryName, cityName: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case userName = "user_name"
        case followingCount = "following_count"
        case followersCount = "followers_count"
        case countryName = "country_name"
        case cityName = "city_name"
    }
}
