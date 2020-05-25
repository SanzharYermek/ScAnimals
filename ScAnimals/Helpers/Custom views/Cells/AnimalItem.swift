//
//  AnimalItems.swift
//  ScAnimals
//
//  Created by I on 2/29/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class AnimalItem: UICollectionViewCell {

    private(set) var iconView: AnimalImageView = AnimalImageView()
    private(set) var titleLabelView: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titleLabelView.sizeToFit()
//        titleLabelView.textAlignment = .center
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with snapshot: DataSnapshot) -> Void {
        titleLabelView.text = snapshot.childSnapshot(forPath: "name").value as? String
        if let images = snapshot.childSnapshot(forPath: "images").value as? [String] {
            if let urlString = images.first {
                iconView.iconImageView.kf.indicatorType = .activity
                iconView.iconImageView.kf.setImage(with: URL.init(string: urlString))
            }
        }
    }
    
}

private extension AnimalItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.3215686275, blue: 0.3764705882, alpha: 1)
        layer.cornerRadius = 14
        clipsToBounds = true

        //icon view
        iconView.layer.cornerRadius = 38
        iconView.iconImageView.image = #imageLiteral(resourceName: "animal")

        //title label view
        titleLabelView.textAlignment = .center
        titleLabelView.font = .systemFont(ofSize: 15)
        titleLabelView.textColor = .white
        titleLabelView.numberOfLines = 0
        titleLabelView.sizeToFit()
    }

    func buildLayouts() -> Void {

        addSubviews([iconView, titleLabelView])
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(76)
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }

        titleLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.right.equalTo(-8)
            make.left.equalTo(8)
        }
    }
}

