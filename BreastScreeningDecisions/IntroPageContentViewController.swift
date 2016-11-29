//
//  IntroPageContentViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/14/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class IntroPageContentViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var parentViewHeightConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        DispatchQueue.global(qos: .background).async {
            while(self.contentLabel.bounds.size.width > self.view.bounds.size.width) {
                _ = true
            }
            DispatchQueue.main.async {
                self.parentViewHeightConst.constant = self.headerLabel.getLabelHeightByWidth() + self.contentLabel.getLabelHeightByWidth() +  50.0
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
