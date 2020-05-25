//
//  DescriptionItem.swift
//  ScAnimals
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class DescriptionItem: UITableViewCell {

    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var valueLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: AnimalDescriptionModel) -> Void {
        titleLabelView.text = item.title
        valueLabelView.text = item.value
    }
}

extension DescriptionItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        selectionStyle = .none

        //title label view
        titleLabelView.font = .systemFont(ofSize: 18)
        titleLabelView.textColor = .white
        titleLabelView.numberOfLines = 2
        titleLabelView.sizeToFit()

        //text view
        valueLabelView.font = .systemFont(ofSize: 14)
        valueLabelView.textColor = .white
        valueLabelView.numberOfLines = 0
        valueLabelView.sizeToFit()
    }

    func buildLayouts() -> Void {

        addSubviews([titleLabelView, valueLabelView])
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.right.equalTo(-15)
        }

        valueLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabelView.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabelView)
            make.bottom.equalTo(-15)
        }
    }
}
