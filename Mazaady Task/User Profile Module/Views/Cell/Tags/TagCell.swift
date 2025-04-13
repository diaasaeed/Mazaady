//
//  testCollectionViewCell.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import UIKit


class TagCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.backgroundColor = .white

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
 
    }


    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        contentView.backgroundColor = isSelected ? UIColor.orange.withAlphaComponent(0.1) : .white
        titleLabel.textColor = isSelected ? .orange : .black
        contentView.layer.borderColor = isSelected ? UIColor.orange.cgColor : UIColor.lightGray.cgColor
    }
}
