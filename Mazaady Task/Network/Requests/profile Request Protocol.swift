//
//  profile Request Protocol.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
protocol ProfileRepository {
    func fetchProduct(callback: @escaping (Result<[ProductModel], APIError>) -> ())
    func fetchTags(callback: @escaping (Result<TagsModel, APIError>) -> ())
    func fetchAdvertisements(callback: @escaping (Result<AdsModel, APIError>) -> ())
    func fetchUser(callback: @escaping (Result<UserInfoModel, APIError>) -> ())

}

protocol HasProfileRepository {
    var repository: ProfileRepository { get }
}



class ProfileDependencies:  HasProfileRepository{
    
    var repository: ProfileRepository

//
    init(repository: ProfileRepository) {
        self.repository = repository

    }
}

extension ProfileDependencies {
    static var shared: ProfileDependencies {
        ProfileDependencies(
            repository: ProfileRequestAPI()

        )
    }
}

/// we make dependencies `var` when we are in debug mode, since changing dependencies should only be used for testing purposes only
#if DEBUG
var dependencies: ProfileDependencies = .shared
#else
let dependencies: ProfileDependencies = .shared
#endif
