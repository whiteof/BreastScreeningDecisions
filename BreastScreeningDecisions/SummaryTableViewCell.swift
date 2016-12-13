//
//  SummaryTableViewCell.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/28/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell, UIWebViewDelegate {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var cellContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailTopInsent: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.cellContentViewHeight.constant = 800.0
        let url = Bundle.main.url(forResource: "summary", withExtension: "pdf")
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }

}
