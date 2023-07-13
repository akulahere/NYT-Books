//
//  WebViewController.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, ErrorHandler {

    var webView: WKWebView!
    var url: URL?

    init(url: URL?) {
         self.url = url
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            loadURL(url)
        }
    }
    
    func loadURL(_ url: URL) {
        view.showSpinner()
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.hideSpinner()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view.hideSpinner()
        present(error: error)
    }
}
