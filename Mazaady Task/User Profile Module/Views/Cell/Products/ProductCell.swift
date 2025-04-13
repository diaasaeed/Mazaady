//
//  ProductCell.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import UIKit
import SDWebImage
class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var priceStack: UIStackView!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var offerStack: UIStackView!
    @IBOutlet weak var orignalPriceLable: UILabel!
    @IBOutlet weak var discountPriceLable: UILabel!
    @IBOutlet weak var timeStartStackView: UIStackView!
    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var minutesLable: UILabel!
    
    var currency = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupShadow()
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    // Product Data
    func setData(item:ProductModel){
        currency = item.currency ?? ""
        productImage.sd_setImage(with: URL(string: item.image ?? ""),
                                 placeholderImage: UIImage(named: "placeholder-image"))
        titleLable.text = item.name ?? ""
        if item.offer ?? 0 == 0 {
            self.offerStack.isHidden = true
            self.priceStack.isHidden = false
            
            self.priceLable.text = String(item.price ?? 0) + " " + currency
        }else{
            self.offerStack.isHidden = false
            self.priceStack.isHidden = true
            
            self.orignalPriceLable.attributedText = "\(item.price ?? 0) \(currency)".withStrikethrough()
            self.discountPriceLable.text = String(item.offer ?? 0) + " " + currency
        }
        
        
        self.formatSecondsToCountdown(item.endDate ?? 0)
        if item.endDate ?? 0 == 0{
            self.timeStartStackView.isHidden = true
        }else{
            self.timeStartStackView.isHidden = false

        }
    }
    
    
    // Count Down
    func formatSecondsToCountdown(_ seconds: Double) {
        let totalSeconds = Int(seconds)
        
        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60
        
        self.daysLable.text = "\(days) D"
        self.hoursLable.text = "\(hours) H"
        self.minutesLable.text = "\(minutes) M"
        
    }
    
    
    // Shadow
    private func setupShadow() {
        // Add shadow to the cell
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        // Rounded corners
        layer.cornerRadius = 12

        // Ensure contentView also has rounded corners
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        // Improve performance
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}


extension String {
    func withStrikethrough() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(
            .strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: self.count))
        return attributedString
    }
}
