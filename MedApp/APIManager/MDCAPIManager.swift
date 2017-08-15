//
//  MDCAPIManager.swift
//  MedApp
//
//  Created by Philip Starner on 8/13/17.
//  Copyright © 2017 MedApp. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MDCAPIManager {
    //singleton
    static let sharedInstance = MDCAPIManager()
    private init() {}
    
    /// get a list of makes
    /// https://medcircle-coding-project.s3.amazonaws.com/api/articles.json
    ///
    /// :param: callback: onCompletion 'make' data.
    func getArticleDataList(onCompletion: ((_ articleListPage: MDCArticleBase?, _ error: NSError?) -> Void)?) {
        let requestString = (Constants.HOST + "articles.json")
        
        Alamofire.request(requestString).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while getting Articles: \(String(describing: response.result.error))")
                onCompletion?(nil, response.result.error as NSError?)
                return
                
                
            }
            
            let jsonData = JSON.init(data: response.data! as Data)
            let articleBase = MDCArticleBase.init(json: jsonData)
                
            onCompletion?(articleBase, nil)
        }
    }
    
    /// get a list of makes
    /// https://medcircle-coding-project.s3.amazonaws.com/api/articles/2832.json
    ///
    /// :param: callback: onCompletion 'make' data.
    func getArticle(articleId: String, onCompletion: ((_ article: MDCArticle?, _ error: NSError?) -> Void)?) {
        let requestString = (Constants.HOST + "/articles/\(articleId).json")
        
        Alamofire.request(requestString).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while getting Articles: \(String(describing: response.result.error))")
                onCompletion?(nil, response.result.error as NSError?)
                return
                
                
            }
            
            let jsonData = JSON.init(data: response.data! as Data)
            let article = MDCArticle.init(json: jsonData)
            
            onCompletion?(article, nil)
        }
    }
}
