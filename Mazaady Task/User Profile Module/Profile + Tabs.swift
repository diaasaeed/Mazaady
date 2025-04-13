//
//  Profile + Tabs.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import Foundation
import UIKit

//MARK: - tabs
extension ProfileViewController : CustomTabBarDelegate{
    
    // UI
    func SetupTabUI(){
        let customTabBar = CustomTabBar(tabs: ["Products", "Reviews", "Followers"])
        customTabBar.backgroundColor = .clear
        customTabBar.delegate = self

        view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.topAnchor.constraint(equalTo: tabBarView.safeAreaLayoutGuide.topAnchor),
            customTabBar.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    // Action
    func didSelectTab(index: Int) {
            print("Selected tab at index: \(index)")
        
        
            // Perform your actions here (switch views, update content, etc.)
        }
}
