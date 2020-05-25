//
//  UITableView+Extensions.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func loading() -> Void {
        self.backgroundView = LoadingView()
    }

    func error(with error: Error, with retry: @escaping ()->()) -> Void {
        self.backgroundView = RetryBackgroundView.init(with: error.localizedDescription, retry: {

            retry()
        })
    }

    func clear() -> Void {
        self.backgroundView = nil
    }

    func message(with message: String) -> Void {
        self.backgroundView = MessageBackgroundView(with: message)
    }
}
