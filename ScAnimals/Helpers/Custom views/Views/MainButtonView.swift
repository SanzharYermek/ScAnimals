//
//  MainButtonView.swift
//  ScAnimals
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MainButtonView: UIButton {

    private lazy var activityLoadingView: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .white)

    override init(frame: CGRect) {
        super.init(frame: frame)

        activityLoadingView.hidesWhenStopped = true
        addSubview(activityLoadingView)
        activityLoadingView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainButtonView {

    func showLoading() -> Void {
        activityLoadingView.startAnimating()
        setTitle(nil, for: .normal)
    }

    func hideLoading() -> Void {
        activityLoadingView.stopAnimating()
        setTitle("Сканировать", for: .normal)
    }
}

