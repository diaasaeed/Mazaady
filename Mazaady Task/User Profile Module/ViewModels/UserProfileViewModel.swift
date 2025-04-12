//
//  UserProfileViewModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import Foundation
import RxSwift
import RxCocoa
//class UserProfileViewModel{
//    
//    
//    func getProduct(){
//        dependencies.repository.fetchProduct { result in
//            switch result {
//            case .success(let data):
//                print("Data",data)
//            case .failure(let error):
//                print("Data",error.localizedDescription)
//            }
//        }
//    }
//    
//    
//    func getUserInfo(){
//        dependencies.repository.fetchUser { result in
//            switch result {
//            case .success(let data):
//                print("Data",data)
//            case .failure(let error):
//                print("Data",error.localizedDescription)
//            }
//        }
//    }
//    
//    
//    func getTags(){
//        dependencies.repository.fetchTags  { result in
//            switch result {
//            case .success(let data):
//                print("Data",data)
//            case .failure(let error):
//                print("Data",error.localizedDescription)
//            }
//        }
//    }
//    
//    
//    func getAds(){
//        dependencies.repository.fetchAdvertisements { result in
//            switch result {
//            case .success(let data):
//                print("Data",data)
//            case .failure(let error):
//                print("Data",error.localizedDescription)
//            }
//        }
//    }
//}


import RxSwift

struct UserProfileData {
    let products: [ProductModel]
    let userInfo: UserInfoModel
    let tags: TagsModel
    let ads: AdsModel
}

class UserProfileViewModel {
    private let disposeBag = DisposeBag()
    
    // Public observables for the view controller
    let isLoading = BehaviorSubject<Bool>(value: false)
    let profileData = PublishSubject<UserProfileData>()
    let errorSubject = PublishSubject<Error>()
    
//    init(dependencies: Dependencies) {
//        self.dependencies = dependencies
//    }
    
    // Main function to fetch all data
    func fetchAllData() {
        isLoading.onNext(true)
        
        Observable.zip(
            fetchProducts(),
            fetchUserInfo(),
            fetchTags(),
            fetchAds()
        )
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] (products, userInfo, tags, ads) in
            let combinedData = UserProfileData(
                products: products,
                userInfo: userInfo,
                tags: tags,
                ads: ads
            )
            self?.profileData.onNext(combinedData)
            self?.isLoading.onNext(false)
        }, onError: { [weak self] error in
            self?.errorSubject.onNext(error)
            self?.isLoading.onNext(false)
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private Network Methods
    
    private func fetchProducts() -> Observable<[ProductModel]> {
        return Observable.create { observer in
            dependencies.repository.fetchProduct { result in
                switch result {
                case .success(let products):
                    observer.onNext(products)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    private func fetchUserInfo() -> Observable<UserInfoModel> {
        return Observable.create { observer in
            dependencies.repository.fetchUser { result in
                switch result {
                case .success(let user):
                    observer.onNext(user)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    private func fetchTags() -> Observable<TagsModel> {
        return Observable.create { observer in
            dependencies.repository.fetchTags { result in
                switch result {
                case .success(let tags):
                    observer.onNext(tags)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    private func fetchAds() -> Observable<AdsModel> {
        return Observable.create { observer in
            dependencies.repository.fetchAdvertisements { result in
                switch result {
                case .success(let ads):
                    observer.onNext(ads)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
