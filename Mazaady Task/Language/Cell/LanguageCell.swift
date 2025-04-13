//
//  LanguageCell.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 13/04/2025.
//

import UIKit

class LanguageCell: UITableViewCell {
    static let identifier = "LanguageCell"

    
    @IBOutlet weak var imgLang: UIImageView!
    @IBOutlet weak var titleLang: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
    func configure(with language: Language, isSelected: Bool) {
        titleLang?.text = language.name
        if isSelected == true{
            self.imgLang.image = UIImage(named: "selected")
        }else{
            self.imgLang.image = UIImage(named: "unselected")
        }
    }
    
}
