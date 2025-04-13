//
//  profile + CollectionView.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 13/04/2025.
//

import Foundation
import RxSwift

//MARK: - collection view  UI

extension ProfileViewController : UICollectionViewDelegateFlowLayout{
    
    func setupNib(){
        
        ProductsCollectionView.register(UINib(nibName: "ProductCell", bundle: nil).self,
                                        forCellWithReuseIdentifier: "ProductCell")
        advertisementsCollectionView.register(UINib(nibName: "AdsCell", bundle: nil),
                                              forCellWithReuseIdentifier: "AdsCell")
        
        tagsCollectionView.register(UINib(nibName: "TagCell", bundle: nil),
                                    forCellWithReuseIdentifier: "TagCell")
    }
    
    
    func setupCollectionsUI(productHeight:CGFloat , adsHeight:CGFloat) {
        stackView.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        // Setup ScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: listView.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: listView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: listView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: listView.bottomAnchor)
        ])
        
        // Setup StackView
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32) // Match scrollView width
        ])
        
        // Add collectionViews
        // Set different heights for collection views
        
        
        
        // Add collectionViews to stack view
        [ProductsCollectionView, advertisementsCollectionView , tagsCollectionView].forEach { collectionView in
            stackView.addArrangedSubview(collectionView)
        }
    }
    
    func createVerticalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           if collectionView == ProductsCollectionView {
               // Product cell size
               let width = (collectionView.frame.width - 24) / 2 // 2 columns with 12 spacing
               return CGSize(width: width, height: 230) // Product cell height
          
           } else if collectionView == advertisementsCollectionView {
               // Ad cell size - full width
               return CGSize(width: collectionView.frame.width - 20, height: 132)
           } else if collectionView == tagsCollectionView {
               // Tag cell size
               return CGSize(width: tagWidths[indexPath.row], height: 40)

           }
           
           return CGSize(width: 100, height: 100) // Default size
       }
       
}


extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offsetY = scrollView.contentOffset.y
           
           // Calculate percentage scrolled
           let scrollPercentage = min(1, max(0, offsetY / headerHideThreshold))
           
           if offsetY > 0 {
               // Scrolling down
               if !isHeaderHidden {
                   let newHeight = originalHeaderHeight * (1 - scrollPercentage)
                   headerHeigth.constant = newHeight
                   
                   // Fully hide if scrolled past threshold
                   if offsetY >= headerHideThreshold {
                       isHeaderHidden = true
                       headerHeigth.constant = 0
                   }
               }
           } else {
               // Scrolling up
               if isHeaderHidden || headerHeigth.constant < originalHeaderHeight {
                   isHeaderHidden = false
                   let newHeight = min(originalHeaderHeight, originalHeaderHeight * (1 - scrollPercentage))
                   headerHeigth.constant = newHeight
               }
           }
           
           // Animate changes
           UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
               self.view.layoutIfNeeded()
               
               // Fade out/in effect for header content
               self.headerProfileView.alpha = 1 - scrollPercentage
           })
       }
       
       func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           let offsetY = scrollView.contentOffset.y
           
           // Snap to fully hidden or fully shown when user stops dragging
           if offsetY > 0 && offsetY < headerHideThreshold {
               let shouldHide = offsetY > headerHideThreshold / 2
               isHeaderHidden = shouldHide
               headerHeigth.constant = shouldHide ? 0 : originalHeaderHeight
               
               UIView.animate(withDuration: 0.3, animations: {
                   self.view.layoutIfNeeded()
                   self.headerProfileView.alpha = shouldHide ? 0 : 1
               })
           }
       }
}
