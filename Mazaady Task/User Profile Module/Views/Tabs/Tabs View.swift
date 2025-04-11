//
//  Tabs View.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 11/04/2025.
//

import Foundation
import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(index: Int)
}

class CustomTabBar: UIView {
    
    private var buttons: [UIButton] = []
    private var underlineViews: [UIView] = []
    private var stackView: UIStackView!
    weak var delegate: CustomTabBarDelegate?
    
    private let activeColor = UIColor(hex: "#D20653")
    private let inactiveColor = UIColor(hex: "#828282")
    
    private var selectedIndex: Int = 0

    init(tabs: [String]) {
        super.init(frame: .zero)
        setupTabs(tabs: tabs)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

    private func setupTabs(tabs: [String]) {
        buttons = tabs.enumerated().map { (index, title) in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == selectedIndex ? activeColor : inactiveColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            return button
        }

        underlineViews = tabs.enumerated().map { (index, _) in
            let view = UIView()
            view.backgroundColor = index == selectedIndex ? activeColor : .clear
            return view
        }

        let tabViews = zip(buttons, underlineViews).map { button, underline in
            let container = UIStackView(arrangedSubviews: [button, underline])
            container.axis = .vertical
            underline.heightAnchor.constraint(equalToConstant: 2).isActive = true
            return container
        }

        stackView = UIStackView(arrangedSubviews: tabViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func tabTapped(_ sender: UIButton) {
        updateSelection(index: sender.tag)
        delegate?.didSelectTab(index: sender.tag)
    }

    func updateSelection(index: Int) {
        for (i, button) in buttons.enumerated() {
            button.setTitleColor(i == index ? activeColor : inactiveColor, for: .normal)
            underlineViews[i].backgroundColor = i == index ? activeColor : .clear
        }
        selectedIndex = index
    }
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
