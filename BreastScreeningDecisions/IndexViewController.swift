//
//  IndexViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit
import ResearchKit

class IndexViewController: UIViewController {
    
    var contentHidden = false {
        didSet {
            guard contentHidden != oldValue && isViewLoaded else { return }
            childViewControllers.first?.view.isHidden = contentHidden
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            performSegue(withIdentifier: "toDashboard", sender: self)
        }
        else {
            performSegue(withIdentifier: "toIntro", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToDashboard(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "toDashboard", sender: self)
    }
    
    @IBAction func unwindToIntro(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "toIntro", sender: self)
    }
    
}


