//
//  PinterestLayout.swift
//  ScAnimals
//
//  Created by I on 4/23/20.
//  Copyright © 2020 Yerzhan. All rights reserved.
//

import Foundation
import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {

    // 1
    weak var delegate: PinterestLayoutDelegate?

    // 2
    private let numberOfColumns = 3
    private let insetValue: CGFloat = 15

    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []

    // 4
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.frame.size.width - 60
    }

    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        cache.removeAll()
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // 2
        let columnWidth = (contentWidth/CGFloat(3))
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            let column = CGFloat(column)
            xOffset.append(column * columnWidth + insetValue * (column + 1))
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: insetValue, count: numberOfColumns)

        // 3
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            // 4
            let labelHeight = delegate!.collectionView(
                collectionView,
                heightForLabelAtIndexPath: indexPath)
            let height = insetValue + labelHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)

            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height + insetValue

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

            // Loop through the cache and look for items in the rect
            for attributes in cache {
                visibleLayoutAttributes.append(attributes)
            }
            return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
}

