//
//  UserProfileViewModel.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import Foundation
import RxSwift
import RxCocoa

import RxSwift


class UserProfileViewModel {
    private let disposeBag = DisposeBag()
    
    // Public observables for the view controller
    let isLoading = BehaviorSubject<Bool>(value: false)
    let productsData = PublishSubject<[ProductModel]>()
    let userInfoData = PublishSubject<UserInfoModel>()
    let tagsData = PublishSubject<[Tag]>()
    let adsData = PublishSubject<[Advertisement]>()

    let errorSubject = PublishSubject<Error>()
    

    private let cache: DataCache
    private let networkQueue = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    
    init(cache: DataCache = UserDefaultsCache()) {
        self.cache = cache
    }
    
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

            self?.userInfoData.onNext(userInfo)
            self?.tagsData.onNext(tags.tags ?? [])
            self?.adsData.onNext(ads.advertisements ?? [])
            self?.productsData.onNext(products)

//            self?.profileData.onNext(combinedData)
            self?.isLoading.onNext(false)
        }, onError: { [weak self] error in
            self?.errorSubject.onNext(error)
            self?.isLoading.onNext(false)
        })
        .disposed(by: disposeBag)
    }
    
    
    
    //MARK: -  Products  Methods with Caching
    private func fetchProducts() -> Observable<[ProductModel]> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            // Try to load from cache first if not forcing refresh
            if let cached: [ProductModel] = self.cache.load([ProductModel].self, forKey: CacheKeys.products) {
                observer.onNext(cached)
            }
            
            // Always fetch from network
            dependencies.repository.fetchProduct { result in
                switch result {
                case .success(let products):
                    // Only update if different from cache
                    if  !self.isDataEqual(products, forKey: CacheKeys.products) {
                        self.cache.save(products, forKey: CacheKeys.products)
                    }
                    observer.onNext(products)
                    observer.onCompleted()
                case .failure(let error):
                    // If we have cached data and network fails, return cache
                    if let cached: [ProductModel] = self.cache.load([ProductModel].self, forKey: CacheKeys.products) {
                        observer.onNext(cached)
                        observer.onCompleted()
                    } else {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
        .subscribe(on: networkQueue)
    }
        
    //MARK: -  userInfo  Methods with Caching
    private func fetchUserInfo() -> Observable<UserInfoModel> {
            return Observable.create { [weak self] observer in
                guard let self = self else { return Disposables.create() }
                
                if let cached: UserInfoModel = self.cache.load(UserInfoModel.self, forKey: CacheKeys.userInfo) {
                    observer.onNext(cached)
                }
                
                dependencies.repository.fetchUser { result in
                    switch result {
                    case .success(let user):
                        if !self.isDataEqual(user, forKey: CacheKeys.userInfo) {
                            self.cache.save(user, forKey: CacheKeys.userInfo)
                        }
                        observer.onNext(user)
                        observer.onCompleted()
                    case .failure(let error):
                        if let cached: UserInfoModel = self.cache.load(UserInfoModel.self, forKey: CacheKeys.userInfo) {
                            observer.onNext(cached)
                            observer.onCompleted()
                        } else {
                            observer.onError(error)
                        }
                    }
                }
                return Disposables.create()
            }
            .subscribe(on: networkQueue)
        }
    
    //MARK: - Tags  Methods with Caching
    private func fetchTags() -> Observable<TagsModel> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            if let cached: TagsModel = self.cache.load(TagsModel.self, forKey: CacheKeys.tags) {
                observer.onNext(cached)
            }
            
            dependencies.repository.fetchTags { result in
                switch result {
                case .success(let tags):
                    if  !self.isDataEqual(tags, forKey: CacheKeys.tags) {
                        self.cache.save(tags, forKey: CacheKeys.tags)
                    }
                    observer.onNext(tags)
                    observer.onCompleted()
                case .failure(let error):
                    if let cached: TagsModel = self.cache.load(TagsModel.self, forKey: CacheKeys.tags) {
                        observer.onNext(cached)
                        observer.onCompleted()
                    } else {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
        .subscribe(on: networkQueue)
    }
    
    //MARK: - Ads  Methods with Caching
    private func fetchAds() -> Observable<AdsModel> {
            return Observable.create { [weak self] observer in
                guard let self = self else { return Disposables.create() }
                
                if let cached: AdsModel = self.cache.load(AdsModel.self, forKey: CacheKeys.ads) {
                    observer.onNext(cached)
                }
                
                dependencies.repository.fetchAdvertisements { result in
                    switch result {
                    case .success(let ads):
                        if !self.isDataEqual(ads, forKey: CacheKeys.ads) {
                            self.cache.save(ads, forKey: CacheKeys.ads)
                        }
                        observer.onNext(ads)
                        observer.onCompleted()
                    case .failure(let error):
                        if let cached: AdsModel = self.cache.load(AdsModel.self, forKey: CacheKeys.ads) {
                            observer.onNext(cached)
                            observer.onCompleted()
                        } else {
                            observer.onError(error)
                        }
                    }
                }
                return Disposables.create()
            }
            .subscribe(on: networkQueue)
        }
    
    
    
    private func isDataEqual<T: Equatable & Codable>(_ newData: T, forKey key: String) -> Bool {
         guard let cached: T = cache.load(T.self, forKey: key) else { return false }
         return newData == cached
     }
     
}






