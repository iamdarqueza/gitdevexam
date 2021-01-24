//
//  UIViewController+Alerts.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/24/21.
//

import Foundation
import UIKit

extension UIViewController {

    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        alertController.addAction(dismissAlertAction)

        present(alertController, animated: true, completion: nil)

        return alertController
    }


    func presentErrorAlertController(error: Error) {
        let title = error.localizedDescription
        presentDismissableAlertController(title: title, message: nil)
    }

    func presentErrorAlertController(error: Error, withBlock completion: @escaping () -> Void) {
        let title = error.localizedDescription
        presentDismissableAlertController(title: title, message: nil, withBlock: {
            completion()
        })
    }

    @discardableResult
    func presentDismissableAlertController(title: String?, message: String?, withBlock completion: @escaping () -> Void ) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAlertAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            completion()
        }

        alertController.addAction(dismissAlertAction)

        present(alertController, animated: true, completion: nil)

        return alertController
    }
}
