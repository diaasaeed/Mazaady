//
//  ViewController.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 10/04/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerProfileView: UIView!
    @IBOutlet weak var tabBarView: CustomTabBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customTabBar = CustomTabBar(tabs: ["Products", "Reviews", "Followers"])
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


}


extension ViewController : CustomTabBarDelegate{
    func didSelectTab(index: Int) {
            print("Selected tab at index: \(index)")
            // Perform your actions here (switch views, update content, etc.)
        }
}
