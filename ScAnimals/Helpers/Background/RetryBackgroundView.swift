//
//  RetryBackgroundView.swift
//  Delta
//
//  Created by I on 2/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class RetryBackgroundView: UIView {

    var retryEvent: (()->())?

    init(with title: String, retry: @escaping ()->()) {
        self.retryEvent = retry
        super.init(frame: .zero)
        self.messageLabel.text = title
        setupViews()
        setupBackground()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() -> Void {

        addSubviews([messageLabel, retryButton])
        NSLayoutConstraint.activate([

            ///Message Label constraint
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),

            ///Retry Button constraint
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            retryButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
            ])

    }

    func setupBackground() -> Void {

        backgroundColor = .white
    }

    @objc func handleRetryEvent() -> Void {
        retryEvent?()
    }

    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 16)

        return view
    }()

    lazy var retryButton: UIButton = {
        let view = UIButton()
        view.setTitle("Обновить", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleRetryEvent), for: .touchUpInside)

        return view
    }()
}



