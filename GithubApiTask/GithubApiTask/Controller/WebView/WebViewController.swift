//
//  WebViewViewController.swift
//  GithubApiTask
//
//  Created by Kazunori Aoki on 2021/06/08.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!

    // MARK: - Properties
    var webView: WKWebView!
    var url: URL?

    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()

        setupWebView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: setup
    private func setupWebView() {

        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.backgroundView.bounds,
                            configuration: configuration)
        webView.uiDelegate = self
        backgroundView.addSubview(webView)

        webView.allowsBackForwardNavigationGestures = true
    }

    private func setup() {

        guard let url = url else {
            present(.okAlert(title: nil, message: "URLが存在しません", okHandler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }

    // MARK: - IBAction
    @IBAction func tapBackBtn(_ sender: Any) {
        webView.goBack()
    }

    @IBAction func tapForwardBtn(_ sender: Any) {
        webView.goForward()
    }
}

extension WebViewController: WKUIDelegate {

    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {

        present(.okAlert(title: nil, message: message, okHandler: { _ in
            completionHandler()
        }))
    }

    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {

        present(.okCancelAlert(title: nil, message: message, okHandler: { _ in
            completionHandler(true)
        }, cancelHandler: { _ in
            completionHandler(false)
        }))
    }

    func webView(_ webView: WKWebView,
                 runJavaScriptTextInputPanelWithPrompt prompt: String,
                 defaultText: String?,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {

        let alertController  = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        let okHandler: () -> Void = {
            if let textField = alertController.textFields?.first {
                completionHandler(textField.text)
            } else {
                completionHandler("")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            completionHandler(nil)
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okHandler()
        }
        alertController.addTextField { $0.text = defaultText }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
