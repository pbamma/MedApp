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
    var selectedArticleURLString:String?
    var selectedTitle = "Article"
    var selectedTitleString = "Article"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MDCAPIManager.sharedInstance.getArticleDataList { (articleBase: MDCArticleBase?, error: NSError?) in
            //
            self.articleBase = articleBase
            
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeShowArticle" {
            let viewController = segue.destination as! ArticleViewController
            viewController.urlString = self.selectedArticleURLString
            viewController.title = self.selectedTitle
            viewController.titleString = self.selectedTitleString
        }
    }

    func displayDownloadedArticles() {
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
                if likesCount == 1 {
                    cell.likesLabel.text = "Like"
                } else {
                    cell.likesLabel.text = "Likes"
                }
                cell.likesLine.alpha = 1
                cell.likesLabel.alpha = 1
                cell.likeCount.alpha = 1
            } else {
                
                cell.likesLine.alpha = 0
                cell.likesLabel.alpha = 0
                cell.likeCount.alpha = 0
            }
            cell.topics.text = articleData.topics?[0].name
            //get the image
            
            if let media = articleData.media, let type = media.first?.type, type.lowercased() == "photo", let urlString = media.first?.url {
                //would love to get video... someday
                if let thumbURL = URL.init(string: urlString) {
                    let thumbRequest = URLRequest.init(url: thumbURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
                    
                    cell.imageThumb.setImageWith(thumbRequest as URLRequest, placeholderImage: UIImage.init(named: ""), success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) in
                        
                        cell.imageThumb.image = image
                        cell.setNeedsLayout()
                    })
                }
            } else {
                //show a default image if no image exists
                //this default is close to our color scheme... so it looks nice-ish
                //it would be nice to have a default set that used a keyword lookup.
                cell.imageThumb.image = UIImage(named: "default-image")
                cell.setNeedsLayout()
            }
            

            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let articleURLString = self.articleBase?.data?[indexPath.item].url  {
            //I DO NOT LIKE this... I'd rather get a better body and style it with MDC styling.  
            self.selectedArticleURLString = articleURLString
            if let title = self.articleBase?.data?[indexPath.item].attribution?.displayName {
                self.selectedTitle = title
            } else {
                self.selectedTitle = "Article"
            }
            
            if let titleString = self.articleBase?.data?[indexPath.item].title {
                self.selectedTitleString = titleString
            } else {
                self.selectedTitleString = "Article"
            }
            self.performSegue(withIdentifier: "sequeShowArticle", sender: self)
        }
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

