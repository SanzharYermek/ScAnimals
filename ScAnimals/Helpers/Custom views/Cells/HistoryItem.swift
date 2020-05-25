//
//  HistoryItem.swift
//  ScAnimals
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class HistoryItem: UITableViewCell {

    private lazy var nameLabelView: UILabel = UILabel()
    private lazy var typeLabelView: UILabel = UILabel()
    private lazy var photoImageView: UIImageView = UIImageView()
    private lazy var dateLabelView: UILabel = UILabel()
    private lazy var confidenceLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: HistoryModel) -> Void {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        let dateObj = dateFormatter.date(from: item.date.description)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let dateObj = dateObj {
            dateLabelView.text = dateFormatter.string(from: dateObj)
        }

        nameLabelView.text = "\(item.name ?? "")"
        typeLabelView.text = "Тип: \(item.type)"
        confidenceLabelView.text = "Коэффицент: \(item.confidence)%"
        photoImageView.image = UIImage(data: item.image)
    }
}

private extension HistoryItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear

        //photo image view
        photoImageView.image = #imageLiteral(resourceName: "3d7145911ac1aa62c6d939edbeb3e364")
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 8
        photoImageView.clipsToBounds = true

        //name label view
        nameLabelView.text = "Скоттиш-фолд"
        nameLabelView.font = .boldSystemFont(ofSize: 20.0)
        nameLabelView.textColor = .white

        //type label view
        typeLabelView.text = "Тип: кошка"
        typeLabelView.font = .systemFont(ofSize: 13.0)
        typeLabelView.textColor = UIColor.white.withAlphaComponent(0.7)

        //confidence label view
        confidenceLabelView.text = "Коэффицент: 97%"
        confidenceLabelView.font = .systemFont(ofSize: 13.0)
        confidenceLabelView.textColor = UIColor.white.withAlphaComponent(0.7)

        //date label view
        dateLabelView.text = "27.12.98"
        dateLabelView.font = .systemFont(ofSize: 13.0)
        dateLabelView.textColor = .white
        dateLabelView.textAlignment = .right

    }

    func buildLayouts() -> Void {

        addSubviews([photoImageView, nameLabelView, typeLabelView, confidenceLabelView, dateLabelView])
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(15)
            make.bottom.equalTo(-5)
            make.height.width.equalTo(105)
        }

        nameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(15.0)
            make.left.equalTo(photoImageView.snp.right).offset(24)
            make.right.equalTo(-15.0)
        }

        typeLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabelView)
            make.top.equalTo(nameLabelView.snp.bottom).offset(10)
        }

        confidenceLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(typeLabelView)
            make.top.equalTo(typeLabelView.snp.bottom).offset(5)
        }

        dateLabelView.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(confidenceLabelView.snp.bottom).offset(5)
        }
    }
}
