//
//  ProfileRequest.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import Foundation
struct ProfileRequestAPI: ProfileRepository {
 
   
    let client: Client
    init(client: Client = moyaProvider) {
        self.client = client
    }
    
 
    
    func fetchProduct(callback: @escaping (Result<[ProductModel], APIError>) -> ()) {
        self.client.performRequest(api: ProfileAPIEndPoint.products, decodeTo: [ProductModel].self) { (result) in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let aPIError):
                callback(.failure(aPIError))
            }
        }
    }
    
    func fetchTags(callback: @escaping (Result<TagsModel, APIError>) -> ()) {
        self.client.performRequest(api: ProfileAPIEndPoint.tags, decodeTo: TagsModel.self) { (result) in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let aPIError):
                callback(.failure(aPIError))
            }
        }
    }
    
    func fetchAdvertisements(callback: @escaping (Result<AdsModel, APIError>) -> ()) {
        self.client.performRequest(api: ProfileAPIEndPoint.advertisements, decodeTo: AdsModel.self) { (result) in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let aPIError):
                callback(.failure(aPIError))
            }
        }
    }
    
    func fetchUser(callback: @escaping (Result<UserInfoModel, APIError>) -> ()) {
        self.client.performRequest(api: ProfileAPIEndPoint.userInfo, decodeTo: UserInfoModel.self) { (result) in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let aPIError):
                callback(.failure(aPIError))
            }
        }
    }
     
}
