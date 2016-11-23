//
//  ValuesViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/17/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ValuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set status bar white color
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // Update button view
        self.nextButton.layer.cornerRadius = 6.0
        self.nextButton.backgroundColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        self.nextButton.setTitleColor(UIColor.white, for: .normal)
        
        // remove insent
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValuesCell", for: indexPath) as! ValuesTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.title.text = "Every woman's feelings and concerns are different, and it may be helpful to think about what's important to you. The statements and questions below will give you a chance"
        
        cell.cellContentViewHeight.constant = cell.title.frame.height + 110.0
        //7189989900
        /*
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
        }
        if(indexPath.row == 0) {
            let image = UIImageView(frame: CGRect.init(x: 0.0, y: 0.0, width: cell.cellContentView.frame.width, height: 140.0))
            image.image = UIImage(named: "Screening")
            image.contentMode = UIViewContentMode.scaleAspectFill
            cell.cellContentView.addSubview(image)
            cell.cellContentViewHeight.constant = 140.0
        }else {
            // set cell color
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            // build view
            let info = self.buildFooter(frameWidth: (cell.cellContentView.frame.width - 40.0))
            // get view height
            var infoHeight:CGFloat = 0.0
            for constraint in info.constraints {
                if(constraint.firstAttribute == NSLayoutAttribute.height) {
                    infoHeight = constraint.constant
                }
            }
            // set container height by content
            cell.cellContentViewHeight.constant = infoHeight
            // add content
            cell.cellContentView.addSubview(info)
            // set chart relational constraints
            let constraintCenterX = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let constraintCenterY = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
        }
 */
        return cell
    }

    
    func buildHeader(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 0.0
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buildFooter(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 0.0
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    @IBAction func unwindToValues(_ segue: UIStoryboardSegue) {
    }
    
}
