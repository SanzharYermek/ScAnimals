//
//  CoveredImageView.swift
//  ScAnimals
//
//  Created by I on 2/29/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


class CategoryImageView: UIView {

    private(set) var iconImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryImageView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .white
        clipsToBounds = true

        //icon image view
        iconImageView.image = #imageLiteral(resourceName: "animal")
    }

    func buildLayouts() -> Void {

        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.height.equalTo(42)
            make.width.equalTo(46)
            make.center.equalToSuperview()
        }
    }
}
