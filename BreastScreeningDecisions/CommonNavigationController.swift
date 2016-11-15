//
//  CommonNavigationController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/15/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class CommonNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationBar.barTintColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

