//
//  UIAlertController+.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

extension UIAlertController {

    static func okAlert(title: String?,
                        message: String?,
                        okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: okHandler))

        return alert
    }

    static func okCancelAlert(title: String?,
                              message: String?,
                              okTitle: String? = "OK",
                              cancelTitle: String? = "キャンセル",
                              okHandler: ((UIAlertAction) -> Void)? = nil,
                              cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        return alert
    }
}
