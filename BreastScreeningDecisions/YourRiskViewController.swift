//
//  YourRiskViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/15/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class YourRiskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar white color
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // remove insent
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourRiskCell", for: indexPath)
        
        if(indexPath.row == 0) {
            let chart = self.buildChart(percent: 0)
            cell.contentView.addSubview(chart)
            let constraintCenterX = NSLayoutConstraint(item: chart, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let constraintCenterY = NSLayoutConstraint(item: chart, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
        }else {
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            // set screen width and chart size
            let chartWidth = self.view.frame.width - 40.0
            let figureWidth = CGFloat(chartWidth/50.0-1.0)
            let figureHeight = CGFloat(figureWidth*15.0/9.0)
            let cellHeight = CGFloat(((figureHeight+1.0)*20.0)+40.0)
            return cellHeight
        }else {
            return 800.0
        }
    }
    
    func buildChart(percent: Int) -> UIView {
        
        // Draw chart
        let returnView = UIView()
        
        returnView.translatesAutoresizingMaskIntoConstraints = false
        
        let chartWidth = self.view.frame.width - 40.0
        let figureWidth = CGFloat(chartWidth/50.0-1.0)
        let figureHeight = CGFloat(figureWidth*15.0/9.0)
        let chartHeight = CGFloat((figureHeight+1.0)*20.0)
        
        
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: CGFloat(chartHeight))
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        for j in 0...19 {
            for i in 0...49 {
                var imageName = "Chart Figure"
                if j == 0 && i < percent {
                    imageName = "Chart Figure Active"
                }
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                let x = (figureWidth+1.0)*CGFloat(i)
                let y = (figureHeight+1.0)*CGFloat(j)
                imageView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: figureWidth, height: figureHeight)
                if(percent == 0) {
                    imageView.alpha = 0.2
                }
                returnView.addSubview(imageView)
            }
        }
        
        // create title if percent is 0
        if(percent == 0) {
            let headerLabel = UILabel()
            headerLabel.text = "Your Decisions"
            headerLabel.textAlignment = NSTextAlignment.center
            headerLabel.numberOfLines = 0
            headerLabel.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
            headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
            
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            returnView.addSubview(headerLabel)
            
            let headerConstraintWidth = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartWidth)
            let headerConstraintHeight = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartHeight)
            let headerConstraintCenterX = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: returnView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let headerConstraintCenterY = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: returnView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([headerConstraintWidth, headerConstraintHeight, headerConstraintCenterX, headerConstraintCenterY])
            
        }
        
        return returnView
    }
    
}
