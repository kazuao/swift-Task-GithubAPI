//
//  UIViewController+.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

extension UIViewController {

    func present(_ alert: UIAlertController, completion: (() -> Void)? = nil) {
        present(alert, animated: true, completion: completion)
    }

    func present(_ alert: UIAlertController, _ autoDismissInterval: TimeInterval, completion: (() -> Void)? = nil) {
        present(alert, animated: true, completion: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + autoDismissInterval) {
                self?.dismiss(animated: true, completion: completion)
            }
        })
    }

    func startIndicator() {

        let storyboard: UIStoryboard = UIStoryboard(name: "Indicator", bundle: nil)
        if let viewC = storyboard.instantiateViewController(withIdentifier: "Indicator") as? IndicatorViewController {
            viewC.modalPresentationStyle = .overCurrentContext
            self.present(viewC, animated: false, completion: nil)
        }
    }

    func dismissIndicator() {
        let top = topViewController(controller: self)

        if top is IndicatorViewController {
            self.dismiss(animated: false, completion: nil)
        }
    }

    private func topViewController(controller: UIViewController?) -> UIViewController? {
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }

        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }

        return controller
    }
}
