//
//  WebViewController.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 3/3/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class WebViewController: MolinaViewController {

    fileprivate var cachedTitle: String?
    public var url: URL?
    public var webView: WKWebView = WKWebView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.frame = self.view.frame
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        
        self.cachedTitle = self.title
        
        if let url = self.url {
            self.title = NSLocalizedString("common.message.loading", comment: "Title")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.title = self.cachedTitle
    }
}
