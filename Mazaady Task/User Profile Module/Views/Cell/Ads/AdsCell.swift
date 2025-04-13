//
//  AdsCell.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import UIKit

class AdsCell: UICollectionViewCell {

    @IBOutlet weak var adsImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        adsImg.layer.cornerRadius = 10
    }

    func setData(img:String){
        adsImg.sd_setImage(with: URL(string: img))
    }
}
