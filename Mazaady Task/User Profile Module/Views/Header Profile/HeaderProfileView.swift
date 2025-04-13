//
//  HeaderProfileView.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 10/04/2025.
//

import UIKit

@IBDesignable
class HeaderProfileView: UIView {

    @IBOutlet weak var languageLable: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var adderssLable: UILabel!
    @IBOutlet weak var followingCountLable: UILabel!
    @IBOutlet weak var followersCountLable: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        commonInit() 
        SetuserData()
        userProfileImage.layer.cornerRadius = 10
    }
    
    
    // Load UI
    private func commonInit() {
        guard let view = self.loadViewFromNib(nibName: "HeaderProfileView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    
    // User info
    func SetuserData(){
        self.nameLable.text = "Diaa saeed"
        self.usernameLable.text = "DiaaDida"
        self.adderssLable.text = "Cairo"
        self.followersCountLable.text = "11"
        self.followingCountLable.text = "15"
    }
    
    
}
