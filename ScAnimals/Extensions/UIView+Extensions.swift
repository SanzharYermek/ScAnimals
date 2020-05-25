//
//  UIView+Extensions.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addSubviews(_ views: [UIView]) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
}
