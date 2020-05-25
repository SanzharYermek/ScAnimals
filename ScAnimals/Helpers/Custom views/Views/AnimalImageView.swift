//
//  AnimalImageView.swift
//  ScAnimals
//
//  Created by I on 4/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class AnimalImageView: UIView {

    private(set) var iconImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AnimalImageView {

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
        iconImageView.contentMode = .scaleAspectFill
    }

    func buildLayouts() -> Void {

        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

