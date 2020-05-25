//
//  SavedAnimalItem.swift
//  ScAnimals
//
//  Created by I on 2/29/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class SavedAnimalItem: UICollectionViewCell {

    var removeAnimalEvent: (()->())?

    private var backgroundImageView: UIImageView = UIImageView()
    private var titleLabelView: UILabel = UILabel()
    private var toSaveButtonView: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with animal: AnimalModel) -> Void {
        titleLabelView.text = animal.name
        if let urlString = animal.images?.first {
            backgroundImageView.kf.indicatorType = .activity
            backgroundImageView.kf.setImage(with: URL.init(string: urlString))
        }
    }
}

private extension SavedAnimalItem {

    @objc
    func toSavePressed(_ sender: UIButton) -> Void {
        removeAnimalEvent?()
    }
}

private extension SavedAnimalItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true

        //background image view
        backgroundImageView.image = #imageLiteral(resourceName: "background")
        backgroundImageView.contentMode = .scaleAspectFill

        //title label view
        titleLabelView.font = .boldSystemFont(ofSize: 12)
        titleLabelView.textColor = .white

        //to save button view
        toSaveButtonView.backgroundColor = .white
        toSaveButtonView.setImage(#imageLiteral(resourceName: "favorite-1"), for: .normal)
        toSaveButtonView.clipsToBounds = true
        toSaveButtonView.layer.cornerRadius = 12
    }

    func buildLayouts() -> Void {

        addSubviews([backgroundImageView, titleLabelView, toSaveButtonView])
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.bottom.equalTo(-7)
            make.right.equalTo(-8)
        }

        toSaveButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.right.equalTo(-5)
            make.height.width.equalTo(24)
        }
    }

    func buildTargets() -> Void {

        toSaveButtonView.addTarget(self, action: #selector(toSavePressed), for: .touchUpInside)
    }
}
