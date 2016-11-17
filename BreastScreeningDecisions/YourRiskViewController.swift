//
//  YourRiskViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/15/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit
import ResearchKit

class YourRiskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startSurveyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar white color
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // remove insent
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // set button text
        print("********")
        print(ApplicationDataModel.sharedInstance.getRiskPercent())
        print("********")
        if(ApplicationDataModel.sharedInstance.getRiskPercent() > 0) {
            // Enable tab bar
            let tabs = self.tabBarController?.tabBar.items
            let screeningTab = tabs![1]
            screeningTab.isEnabled = true
            let valuesTab = tabs![2]
            valuesTab.isEnabled = true
            // set button title
            self.startSurveyButton.setTitle("Reset Selections", for: UIControlState.normal)
        }else {
            self.startSurveyButton.setTitle("Access My Risk", for: UIControlState.normal)
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourRiskCell", for: indexPath) as! YourRiskTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
        }
        if(indexPath.row == 0) {
            // BUILD CHART
            let chart = self.buildChart(percent: ApplicationDataModel.sharedInstance.getRiskPercent(), chartWidth: cell.cellContentView.frame.width)
            // get chart height
            var chartHeight:CGFloat = 0.0
            for constraint in chart.constraints {
                if(constraint.firstAttribute == NSLayoutAttribute.height) {
                    chartHeight = constraint.constant
                }
            }
            // set container height by content
            cell.cellContentViewHeight.constant = chartHeight
            // add content
            cell.cellContentView.addSubview(chart)
            // set chart relational constraints
            let constraintCenterX = NSLayoutConstraint(item: chart, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let constraintCenterY = NSLayoutConstraint(item: chart, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
        }else {
            // BUILD TEXT CONTENT
            // set cell color
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            // build view
            let info = self.buildInfo(frameWidth: cell.cellContentView.frame.width, riskPercent: ApplicationDataModel.sharedInstance.getRiskPercent())
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
        
        return cell
    }

    func buildChart(percent: Int, chartWidth: CGFloat) -> UIView {
        
        // Draw chart
        let returnView = UIView()
        
        returnView.translatesAutoresizingMaskIntoConstraints = false
        
        let figureWidth = CGFloat(chartWidth/50.0-1.0)
        let figureHeight = CGFloat(figureWidth*15.0/9.0)
        let chartHeight = CGFloat((figureHeight+1.0)*20.0)
        var currentY:CGFloat = chartHeight
        
        for j in 0...19 {
            for i in 0...49 {
                var imageName = "Chart Figure"
                var imageAlpha: CGFloat = 0.1
                if percent == 0 {
                    imageAlpha = 0.1
                }
                if j == 19 && i < percent {
                    imageName = "Chart Figure Active"
                    imageAlpha = 1.0
                }
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                let x = (figureWidth+1.0)*CGFloat(i)
                let y = (figureHeight+1.0)*CGFloat(j)
                imageView.frame = CGRect(x: x, y: y, width: figureWidth, height: figureHeight)
                imageView.alpha = imageAlpha
                returnView.addSubview(imageView)
            }
        }
        
        // create title
        let headerLabel = UILabel()
        if(percent == 0) {
            headerLabel.text = "Your Decisions"
            headerLabel.font = UIFont(name: "Georgia", size: 30.0)
        }else {
            headerLabel.text = "You are at low to average risk of breast cancer"
            headerLabel.font = UIFont(name: "Georgia", size: 24.0)
        }
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.numberOfLines = 0
        headerLabel.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        headerLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerLabel.layer.shadowOpacity = 0.2
        headerLabel.layer.shadowRadius = 4
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        returnView.addSubview(headerLabel)
        
        // create disclaimer
        if percent > 0 {
            // add label1
            currentY = currentY + 10.0
            let label1 = UILabel()
            label1.textAlignment = NSTextAlignment.left
            label1.numberOfLines = 0
            label1.text = "In the next 5 years, 992 will not get breast cancer"
            label1.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
            label1.frame = CGRect(x: 0, y: currentY, width: chartWidth, height: label1.getLabelHeight(byWidth: chartWidth))
            label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label1)
            currentY = currentY + label1.frame.height + 7.0
            // add label2
            let label2 = UILabel()
            label2.textAlignment = NSTextAlignment.left
            label2.numberOfLines = 0
            label2.text = "In the next 5 years, 8 will get breast cancer"
            label2.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
            label2.frame = CGRect(x: 0, y: currentY, width: chartWidth, height: label2.getLabelHeight(byWidth: chartWidth))
            label2.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            returnView.addSubview(label2)
            currentY = currentY + label2.frame.height
            let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartWidth)
            let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
            NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        }else {
            let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartWidth)
            let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: CGFloat(chartHeight))
            NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        }
        
        let dif:CGFloat = (chartHeight - currentY)/2
        let headerConstraintWidth = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: (chartWidth-20))
        let headerConstraintHeight = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartHeight)
        let headerConstraintCenterX = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: returnView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        let headerConstraintCenterY = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: returnView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: dif)
        NSLayoutConstraint.activate([headerConstraintWidth, headerConstraintHeight, headerConstraintCenterX, headerConstraintCenterY])
        
        return returnView
    }
    
    func buildInfo(frameWidth: CGFloat, riskPercent: Int) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 0.0
        if(riskPercent > 0) {
            // SURVEY COMPLETED
            // add label1
            let label1 = UILabel()
            label1.textAlignment = NSTextAlignment.left
            label1.numberOfLines = 0
            label1.text = "Your risk in the next 5 years"
            label1.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
            label1.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
            label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label1)
            currentY = currentY + label1.frame.height + 10.0
            // add label2
            let label2 = UILabel()
            label2.textAlignment = NSTextAlignment.left
            label2.numberOfLines = 0
            label2.text = "Based on your responses, your chance of developing breast cancer in the next 5 years is 0.8%. That means that out of 1000 women like you, 8 of them will develop breast cancer in the next 5 years."
            label2.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label2.frame = CGRect(x: 0, y: currentY, width: frameWidth-20.0, height: label2.getLabelHeight(byWidth: frameWidth))
            label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label2)
            currentY = currentY + label2.frame.height + 10.0
            // add label3
            let label3 = UILabel()
            label3.textAlignment = NSTextAlignment.left
            label3.numberOfLines = 0
            label3.text = "Other things to know"
            label3.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
            label3.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
            label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label3)
            currentY = currentY + label3.frame.height + 10.0
            // add label4
            let label4 = UILabel()
            label4.textAlignment = NSTextAlignment.left
            label4.numberOfLines = 0
            label4.text = "There are other factors such as breast feeding, alcohol intake, body weight, and physical activity that may affect your breast cancer risk. Just how much they affect that risk is not certain."
            label4.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label4.frame = CGRect(x: 0, y: currentY, width: frameWidth-20.0, height: label4.getLabelHeight(byWidth: frameWidth))
            label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label4)
            currentY = currentY + label4.frame.height + 10.0
            // add label5
            let label5 = UILabel()
            label5.textAlignment = NSTextAlignment.left
            label5.numberOfLines = 0
            label5.text = "Now that you know your breast cancer risk, let's talk about mammograms."
            label5.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label5.frame = CGRect(x: 0, y: currentY, width: frameWidth-20.0, height: label5.getLabelHeight(byWidth: frameWidth))
            label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label5)
            currentY = currentY + label5.frame.height - 10.0
        }else {
            // SURVEY NOT COMPLETED
            // add label1
            let label1 = UILabel()
            label1.textAlignment = NSTextAlignment.left
            label1.numberOfLines = 0
            label1.text = "When should you start and how often should you have mammograms to screen for breast cancer?"
            label1.font = UIFont(name:"HelveticaNeue-Regular", size: 18.0)
            label1.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
            label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label1)
            currentY = currentY + label1.frame.height + 10.0
            // add label2
            let label2 = UILabel()
            label2.textAlignment = NSTextAlignment.left
            label2.numberOfLines = 0
            label2.text = "- Should you start in your 40's or wait until you are 50?\n- Should you have a mammogram every year or every other year?"
            label2.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label2.frame = CGRect(x: 20, y: currentY, width: frameWidth-20.0, height: label2.getLabelHeight(byWidth: frameWidth))
            label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label2)
            currentY = currentY + label2.frame.height + 10.0
            // add label3
            let label3 = UILabel()
            label1.tag = 1
            label3.textAlignment = NSTextAlignment.left
            label3.numberOfLines = 0
            label3.text = "The first step in making these decisions is understanding your risk of breast cancer. Press \"Assess My Risk\" to continue."
            label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label3.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
            label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label3)
            currentY = currentY + label3.frame.height - 10.0
        }
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    @IBAction func startSurvey(_ sender: Any) {
        // change status bar colors to default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let taskViewController = ORKTaskViewController(task: SurveyTasks.yourRiskSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
}

extension YourRiskViewController: ORKTaskViewControllerDelegate {
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Set status bar color to white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        switch reason {
        case .completed:
            // Enable tab bar
            let tabs = self.tabBarController?.tabBar.items
            let screeningTab = tabs![1]
            screeningTab.isEnabled = true
            let valuesTab = tabs![2]
            valuesTab.isEnabled = true
            
            ApplicationDataModel.sharedInstance.setYourRiskSurveyTaskResult(data: taskViewController.result)
            ApplicationDataModel.sharedInstance.setRiskPercent(data: 8)
            self.startSurveyButton.setTitle("Reset Selections", for: UIControlState.normal)
            self.tableView.reloadData()
        default:
            print("Not completed!")
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
