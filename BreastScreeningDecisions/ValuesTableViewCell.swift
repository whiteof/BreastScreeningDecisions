//
//  ValuesTableViewCell.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/23/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ValuesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.progressView.layer.cornerRadius = 4.0
        self.progressView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
