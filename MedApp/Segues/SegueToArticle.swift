//
//  SegueToArticle.swift
//  MedApp
//
//  Created by Philip Starner on 8/14/17.
//  Copyright © 2017 MedApp. All rights reserved.
//

import UIKit

class SegueToArticle: UIStoryboardSegue {
    override func perform() {
        let src = self.source as! ArticleListViewController
        let dst = self.destination as! ArticleViewController
        
        //setup zoom transitions per device
        
//        src.coverView?.alpha = 1
//        src.coverImageView?.alpha = 1
//        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
//            src.viewSnapshot?.frame = Constants.sharedInstance.targetVideoRect
//            src.viewSnapshot?.alpha = 0.98
//            src.coverImageView?.alpha = 0
//        }) { (Bool) -> Void in
//            //animation finished
//            src.viewSnapshot?.isHidden = true
//            src.coverView?.alpha = 0
            src.navigationController?.pushViewController(dst, animated: true)
//        }
    }
}
