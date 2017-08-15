//
//  ArticleViewController.swift
//  MedApp
//
//  Created by Philip Starner on 8/14/17.
//  Copyright © 2017 MedApp. All rights reserved.
//
// I DO NOT LIKE this... I'd rather get a better body and style it with MDC styling.  
// this "present in a webview" is essentially a hybrid app... which is ugly IMO... but alas.  time.

import UIKit

class ArticleViewController: UIViewController {
    
    var urlString:String!
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
