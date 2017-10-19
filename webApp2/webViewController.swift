//
//  webViewController.swift
//  webApp2
//
//  Created by ST1 on 18.10.2017.
//  Copyright © 2017 Kugim. All rights reserved.
//

import UIKit
import WebKit


class webViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webKitViewOutlet: UIView!
    
     var webView: WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: webKitViewOutlet.bounds, configuration: WKWebViewConfiguration() )
        self.webKitViewOutlet.addSubview(webView)
        self.webView.allowsBackForwardNavigationGestures = true
        //let localURL = Bundle.main.url(forResource: "index", withExtension: "html")
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
