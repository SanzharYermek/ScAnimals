//
//  ScannableView.swift
//  ScAnimals
//
//  Created by I on 2/29/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class ScannableView: UIView {

    private let coverImageView: UIImageView = UIImageView()
    private let scannableImageView: UIImageView = UIImageView()


    var scannableImageTappedPerformer: (()->())?
    var scannableImage: UIImage? {
        get{
            return scannableImageView.image
        }
        set {
            scannableImageView.image = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ScannableView {

    @objc
    func scannableImageTapped(_ sender: UITapGestureRecognizer) -> Void {

        scannableImageTappedPerformer?()
    }
}

private extension ScannableView {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildGestures()
    }

    func buildViews() -> Void {

        //cover image view
        coverImageView.image = #imageLiteral(resourceName: "Rectangle 8")

        //scannable image view
        scannableImageView.isUserInteractionEnabled = true
    }

    func buildLayouts() -> Void {

        addSubviews([coverImageView, scannableImageView])
        coverImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        scannableImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(4)
            make.bottom.right.equalTo(-4)
        }
    }

    func buildGestures() -> Void {

        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(scannableImageTapped))
        scannableImageView.addGestureRecognizer(tapGestureRecognizer)
    }
}
