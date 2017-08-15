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
    var titleString:String!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = titleString
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.loadRequest(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ArticleViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading {return}
        print("we finished loading")
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: { 
            self.webView.alpha = 1.0
        })
    }
    
}
