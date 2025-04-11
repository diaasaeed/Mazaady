//
//  ViewController.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 10/04/2025.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var headerProfileView: UIView!
    @IBOutlet weak var tabBarView: CustomTabBar!
    @IBOutlet weak var searchBarView: CustomSearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        SetupTabUI()
        searchBarView.actionButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)

    }


    @objc func handleSearch() {
        print("Search tapped with query:", searchBarView.textField.text ?? "")
       }
}
