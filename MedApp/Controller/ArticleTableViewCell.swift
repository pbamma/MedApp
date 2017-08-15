//
//  ArticleTableViewCell.swift
//  MedApp
//
//  Created by Philip Starner on 8/13/17.
//  Copyright © 2017 MedApp. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var attribution: UILabel!
    @IBOutlet weak var topics: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likesLine: UIView!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likesLine.alpha = 0
        likesLabel.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        title.text = nil
        summary.text = nil
        date.text = nil
        attribution.text = nil
        topics.text = nil
        likeCount.text = nil
        
        imageThumb.image = nil
        
        
        likesLine.alpha = 0
        likesLabel.alpha = 0
        likeCount.alpha = 0
    }

}
