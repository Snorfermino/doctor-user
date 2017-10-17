//
//  HelpCentreViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/7/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class HelpCentreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    func loadWebView() {
        let webView = UIWebView()
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        webView.loadRequest(URLRequest(url: URL(string: "http://wongyiunam.com/article_cat_event.php?id=29")!))
    }
}
