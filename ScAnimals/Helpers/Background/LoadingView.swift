//
//  LoadingView.swift
//  Delta
//
//  Created by I on 2/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {

    private lazy var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)

        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: width),
            activityIndicator.heightAnchor.constraint(equalToConstant: height)
        ])

        activityIndicator.color = .lightGray
        activityIndicator.startAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
