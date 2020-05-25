//
//  MessageBackgroundView.swift
//  Delta
//
//  Created by I on 2/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class MessageBackgroundView: UIView {

    init(with message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupViews()
        setupBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() -> Void {

        addSubviews([messageLabel])
        NSLayoutConstraint.activate([

            // Message Label constraint
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }

    func setupBackground() -> Void {

        backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
    }

    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = .white

        return view
    }()
}
