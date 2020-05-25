//
//  UIViewController+Extensions.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func inNavigate() -> UINavigationController {
        return UINavigationController.init(rootViewController: self)
    }

    func showAlert(with title: String, _ message: String) -> Void {

        UIApplication.shared.endIgnoringInteractionEvents()
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
