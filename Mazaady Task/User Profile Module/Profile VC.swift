//
//  ViewController.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 10/04/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController     {
    
    
    @IBOutlet weak var headerProfileView: UIView!
    @IBOutlet weak var headerHeigth: NSLayoutConstraint!
    @IBOutlet weak var tabBarView: CustomTabBar!
    @IBOutlet weak var searchBarView: CustomSearchBar!
    @IBOutlet weak var listView: UIView!
    
    //    private let scrollView = UIScrollView()
    //       private let rootStackView = UIStackView()
    private let viewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()
    private var lottieLoadingTag: Int { return 987654 }

    
    //    init(viewModel: UserProfileViewModel) {
    //        self.viewModel = viewModel
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupTabUI()
        searchBarView.actionButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        setupBindings()
        viewModel.fetchAllData()
        
    }
    
    
    @objc func handleSearch() {
        print("Search tapped with query:", searchBarView.textField.text ?? "")
    }
    
    
    
    private func setupBindings() {
        // Loading state
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            })
            .disposed(by: disposeBag)
        
        // Combined data
        viewModel.profileData
            .subscribe(onNext: { [weak self] data in
                self?.updateUI(with: data)
            })
            .disposed(by: disposeBag)
        
        // Error handling
        viewModel.errorSubject
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(with data: UserProfileData) {
        // Update your UI with all the received data
        print("Products: \(data.products.count)")
        print("User: \(data.userInfo)")
        print("Tags: \(data.tags.tags?.count)")
        print("Ads: \(data.ads.advertisements?.count)")
    }
    
    private func showLoading() {
        // Show loading indicator
        if view.viewWithTag(lottieLoadingTag) != nil { return }
        
        let loadingView = LottieLoadingView()
        loadingView.tag = lottieLoadingTag
        loadingView.show(in: view)
    }
    
    private func hideLoading() {
        if let loadingView = view.viewWithTag(lottieLoadingTag) as? LottieLoadingView {
            loadingView.hide()
        }
    }
    
    private func showError(_ error: Error) {
        // Show error message
        print("Error is",error.localizedDescription)
    }
}

