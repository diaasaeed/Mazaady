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
    @IBOutlet weak var englishLable: UILabel!
    @IBOutlet var stackViwes: [UIStackView]!
    
    var selectionAction: (() -> Void)?
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        commonInit() 
        userProfileImage.layer.cornerRadius = 10
        loadSelectedLanguage()
        
    }
    
   
    // Load UI
    private func commonInit() {
        guard let view = self.loadViewFromNib(nibName: "HeaderProfileView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    
    // User info
    func SetuserData(info:UserInfoModel){
        self.userProfileImage.sd_setImage(with: URL(string: info.image ?? "placeholder-image" ), placeholderImage: UIImage(named: ""))
        self.nameLable.text = info.name ?? ""
        self.usernameLable.text = info.userName ?? ""
        self.adderssLable.text = info.countryName ?? "" + " " + (info.cityName ?? "")
        self.followersCountLable.text = String(info.followersCount ?? 0)
        self.followingCountLable.text = String(info.followingCount ?? 0)
    }
    
    
    @IBAction func langbu(_ sender: Any) {
        self.selectionAction?()
    }
    
    
    func loadSelectedLanguage() {
        let userDefaults = UserDefaults.standard
        let languageKey = "selectedLanguage"
        if let savedData = userDefaults.data(forKey: languageKey) {
            let decoder = JSONDecoder()
            if let loadedLanguage = try? decoder.decode(Language.self, from: savedData) {
                print("SSS",loadedLanguage.code)
                if loadedLanguage.code == "ar"{
                    languageLable.text = "Arabic".localized
                }else{
                    languageLable.text = "English".localized
                }
            }
        }
    }
}
