//
//  CarouselViewCell.swift
//  Jiber
//
//  Created by I on 10/5/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {

    private(set) lazy var imageView: UIImageView = UIImageView()

    // MARK: Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Builds

private extension CarouselViewCell {

    func build() -> Void {

        imageView.contentMode = .scaleAspectFill
        backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        imageView.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        buildLayouts()
    }

    func buildLayouts() -> Void {

        addSubview(imageView)

        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
