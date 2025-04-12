//
//  Loading.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 12/04/2025.
//

import UIKit
import Lottie

class LottieLoadingView: UIView {
    
    private var animationView: LottieAnimationView!
    private let background = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        alpha = 0
        
        background.backgroundColor = .clear
        background.layer.cornerRadius = 16
        background.translatesAutoresizingMaskIntoConstraints = false
        
        animationView = LottieAnimationView(name: "loading") // your Lottie JSON name
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.play()

        addSubview(background)
        background.addSubview(animationView)

        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor),
            background.widthAnchor.constraint(equalToConstant: 150),
            background.heightAnchor.constraint(equalToConstant: 150),

            animationView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    func show(in view: UIView) {
        frame = view.bounds
        view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.animationView.stop()
            self.removeFromSuperview()
        }
    }
}
