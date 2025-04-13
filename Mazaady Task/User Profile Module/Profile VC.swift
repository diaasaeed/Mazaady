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
    
    @IBOutlet weak var headerProfileView: HeaderProfileView!
    @IBOutlet weak var headerHeigth: NSLayoutConstraint!
    @IBOutlet weak var tabBarView: CustomTabBar!
    @IBOutlet weak var searchBarView: CustomSearchBar!
    @IBOutlet weak var listView: UIView!
    
    let viewModel = UserProfileViewModel()
    let disposeBag = DisposeBag()
    private var lottieLoadingTag: Int { return 987654 }
        
    // MARK: - UI Elements
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    lazy var ProductsCollectionView = self.createVerticalCollectionView()
    lazy var advertisementsCollectionView = self.createVerticalCollectionView()
    lazy var tagsCollectionView = self.createVerticalCollectionView()

    var originalHeaderHeight: CGFloat = 300 // Set your initial header height
    var isHeaderHidden = false
    var headerHideThreshold: CGFloat {
            return originalHeaderHeight * 0.5 // Hide when scrolled halfway
        }
    var tagWidths: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupTabUI()
        setupNib()

        searchBarView.actionButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        scrollView.delegate = self

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchAllData()
        AllBinding()

    }
    
    @objc func handleSearch() {
        print("Search tapped with query:", searchBarView.textField.text ?? "")
    }
    
    
    //MARK: - Binding
    
    func AllBinding(){
        bindProfile()
        bindLoading()
        bindProducnts()
        bindAds()
        bindTags()
        CollectionAction()
        bindError()
        setupCollectionsUI(productHeight: 0, adsHeight: 0)
    }
    
    // Profile Data
    private func bindProfile(){
        viewModel.userInfoData
            .subscribe(onNext: { [weak self] info in
                self?.headerProfileView.userProfileImage.sd_setImage(with: URL(string: info.image ?? "placeholder-image" ), placeholderImage: UIImage(named: ""))
                self?.headerProfileView.nameLable.text = info.name ?? ""
                self?.headerProfileView.usernameLable.text = info.userName ?? ""
                self?.headerProfileView.adderssLable.text = info.countryName ?? "" + " " + (info.cityName ?? "")
                self?.headerProfileView.followersCountLable.text = String(info.followersCount ?? 0)
                self?.headerProfileView.followingCountLable.text = String(info.followingCount ?? 0)

            })
            .disposed(by: disposeBag)
    }
    //Loading
    private func bindLoading() {
        // Loading state
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            })
            .disposed(by: disposeBag)
    }
    //Error Handler
    private func bindError(){
        // Error handling
        viewModel.errorSubject
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    // Display Collection View Data
    private func bindProducnts() {

        viewModel.productsData.subscribe(onNext: { [weak self] products in
            let rows = ceil(Double(products.count) / 2.0) // 2 columns
            let height = rows * 230 + (rows - 1) * 12 // cell height + spacing
            print("height",height)
            self?.ProductsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        })
        .disposed(by: disposeBag)
        
        viewModel.productsData
            .bind(to: ProductsCollectionView.rx.items(cellIdentifier: "ProductCell",cellType: ProductCell.self)) { index , item, cell in
                cell.setData(item: item)
            }
            .disposed(by: disposeBag)
        
    }
    
    
    private  func bindAds(){
        viewModel.adsData.subscribe(onNext: { [weak self] data in
            print(data.count)
            
            let rows = ceil(Double(data.count)) // 1 columns
            let height = rows * 132 + (rows - 1) * 12 // cell height + spacing
            let width = UIScreen.main.bounds.width
             
            self?.advertisementsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
            self?.advertisementsCollectionView.widthAnchor.constraint(equalToConstant: width).isActive = true

        })
        .disposed(by: disposeBag)
        
        viewModel.adsData
            .bind(to: advertisementsCollectionView.rx.items(cellIdentifier: "AdsCell",cellType: AdsCell.self)) { index , item, cell in
                cell.setData(img: item.image ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    private func bindTags(){
        viewModel.tagsData.subscribe(onNext:{ [weak self] tag in
            let rows = ceil(Double(tag.count)/3) // 1 columns
            let height = rows * 50 + (rows - 1) * 12 // cell height + spacing
//            let width = UIScreen.main.bounds.width/3
            self?.tagsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
            
            self?.tagWidths = tag.map { tag in
                       let text = tag.name ?? ""
                       let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 12, weight: .medium)]).width + 25
                       return width
                   }
            

        })
        .disposed(by: disposeBag)

        viewModel.tagsData
            .bind(to: tagsCollectionView.rx.items(cellIdentifier: "TagCell", cellType: TagCell.self)){ index , item, cell in
                cell.titleLabel.text = item.name ?? ""
                
            }
            .disposed(by: disposeBag)
    }
    
    // Collection View Action
    private func CollectionAction(){
        ProductsCollectionView.rx.modelSelected(ProductModel.self)
            .subscribe(onNext: { selectedItem in
                print("ProductsCollectionView selected item: \(selectedItem)")
                // You can show alert or update a label here
            })
            .disposed(by: disposeBag)
        
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


