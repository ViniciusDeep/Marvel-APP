//
//  HeroViewController.swift
//  HeroisMarvel
//
//  Created by Vinicius Mangueira on 16/07/18.
//  Copyright © 2018 Vinicius Mangueira. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {

    var hero: Hero!

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: hero.urls.first!.url)
        let request = URLRequest(url: url!)
        title = hero.name
        webView.navigationDelegate = self
        webView.load(request)

    }

}

extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
