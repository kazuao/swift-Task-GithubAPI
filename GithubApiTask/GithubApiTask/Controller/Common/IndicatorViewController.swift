//
//  IndicatorViewController.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit

class IndicatorViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.color = .black
        loadingIndicator.startAnimating()
        firstView.addSubview(loadingIndicator)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        loadingIndicator.stopAnimating()
    }
}
