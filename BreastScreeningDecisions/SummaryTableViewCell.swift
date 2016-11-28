//
//  SummaryTableViewCell.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/28/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailTopInsent: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
