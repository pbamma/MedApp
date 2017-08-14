//
//  ViewController.swift
//  MedApp
//
//  Created by Philip Starner on 8/7/17.
//  Copyright © 2017 MedApp. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

class ArticleListViewController: UIViewController {
    var articleBase:MDCArticleBase?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MDCAPIManager.sharedInstance.getArticleDataList { (articleBase: MDCArticleBase?, error: NSError?) in
            //
            self.articleBase = articleBase
            print("articleBase count: \(articleBase?.data?.count)")
            
            UIView.animate(withDuration: 1.0, animations: { 
                self.logoImageView.alpha = 0
            }, completion: { (complete: Bool) in
                //
                self.displayDownloadedArticles()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayDownloadedArticles() {
        print("were here")
        self.tableView.reloadData()
    }

}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articleCount = self.articleBase?.data?.count {
            return articleCount
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        if let articleData = self.articleBase?.data?[indexPath.item] {
            
            cell.title.text = articleData.title
            cell.summary.text = articleData.summary
            
            if let dateString = formatDateString(dateString: articleData.createdAt!
                ){
                cell.date.text = dateString
                }
            cell.attribution.text = articleData.attribution?.displayName
            if let likesCount = articleData.likesCount, likesCount > 0 {
                cell.likeCount.text = "\(likesCount)"
                print("itme: \(indexPath.item) \(likesCount)")
                if likesCount == 1 {
                    cell.likesLabel.text = "Like"
                } else {
                    cell.likesLabel.text = "Likes"
                }
                cell.likesLine.alpha = 1
                cell.likesLabel.alpha = 1
            } else {
                
                cell.likesLine.alpha = 0
                cell.likesLabel.alpha = 0
            }
            cell.topics.text = articleData.topics?[0].name
            //get the image
            
//            if let thumbURL = URL.init(string: theVehicles[indexPath.item].thumb!) {
//                let thumbRequest = URLRequest.init(url: thumbURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
//                
//                cell.imageThumb.setImageWith(thumbRequest as URLRequest, placeholderImage: UIImage.init(named: ""), success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) in
//                    
//                    cell.imageThumb.image = image
//                    cell.setNeedsLayout()
//                }) { (request: URLRequest, response: HTTPURLResponse?, error: Error) in
//                    //do nothing
//                }
//            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func formatDateString(dateString: String?) -> String? {
        if let dateString = dateString {
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            
            
            let date = dateFormat.date(from: dateString)
            
            let newFormat = DateFormatter()
            newFormat.dateFormat = "MMM, dd yyyy"
            
            return newFormat.string(from: date!)
        }
        return nil

    }
}

