import UIKit

class CustomSearchBar: UIView {

    let textField = UITextField()
    let actionButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        // Search TextField
        textField.placeholder = "Search"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 18
        textField.layer.masksToBounds = false
        textField.borderStyle = .none

        // Apply shadow to the textField
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4

        // Padding for left side
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let iconImage = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconImage.tintColor = UIColor(hex: "#D20653")
        iconImage.frame = CGRect(x: 8, y: 0, width: 20, height: 20)
        iconContainer.addSubview(iconImage)
        textField.leftView = iconContainer
        textField.leftViewMode = .always

        // Action Button
        let playImage = UIImage(named: "searchBu")
        actionButton.setImage(playImage, for: .normal)
        actionButton.tintColor = .white
        actionButton.clipsToBounds = true

        // Layout
        textField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        addSubview(actionButton)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),

            actionButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 12),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 40),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
