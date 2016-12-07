//
//  YourRiskViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/15/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//
import Foundation
import UIKit
import ResearchKit

class YourRiskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startSurveyButton: UIButton!
    
    var isSyncProcessRunning = false
    
    func runSyncTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runSyncProcess), userInfo: nil, repeats: false)
    }
    
    @objc func runSyncProcess() {
        // mark as running
        self.isSyncProcessRunning = true
        
        // send request
        let urlStr = "http://140.251.10.20/get-risk/index.cfm"
        let bodyStr = ApplicationDataModel.sharedInstance.getYourRiskSurveyJson()
        // send request
        SyncHelper.sharedInstance.sendPostJsonRequest(url: urlStr, body: bodyStr, completion: {(result) -> Void in
            
            if(result.responseCode == 200) {
                self.isSyncProcessRunning = false
                ApplicationDataModel.sharedInstance.setYourRiskSurveyResponse(data: result.responseString)
                DispatchQueue.main.async {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    self.startSurveyButton.isHidden = false
                    // Enable tab bar
                    let tabs = self.tabBarController?.tabBar.items
                    let screeningTab = tabs![1]
                    screeningTab.isEnabled = true
                    let valuesTab = tabs![2]
                    valuesTab.isEnabled = true
                    self.startSurveyButton.setTitle("Next", for: UIControlState.normal)
                    // change button width
                    for constraint in self.startSurveyButton.constraints {
                        if(constraint.firstAttribute == NSLayoutAttribute.width) {
                            constraint.constant = 100.0
                        }
                    }
                    self.tableView.reloadData()
                }
            }else {
                self.isSyncProcessRunning = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.runSyncTimer()
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar white color
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // Update button view
        self.startSurveyButton.layer.cornerRadius = 6.0
        self.startSurveyButton.backgroundColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        self.startSurveyButton.setTitleColor(UIColor.white, for: .normal)
        
        // remove insent
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        
        // dynamic table height
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if(ApplicationDataModel.sharedInstance.isYourRiskSurveyResponseReceived()) {
            // Enable tab bar
            let tabs = self.tabBarController?.tabBar.items
            let screeningTab = tabs![1]
            screeningTab.isEnabled = true
            let valuesTab = tabs![2]
            valuesTab.isEnabled = true
            // set button title
            self.startSurveyButton.setTitle("Next", for: UIControlState.normal)
            // change button width
            for constraint in self.startSurveyButton.constraints {
                if(constraint.firstAttribute == NSLayoutAttribute.width) {
                    constraint.constant = 100.0
                }
            }
        }else {
            
            if(!ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
                self.startSurveyButton.setTitle("Access My Risk", for: UIControlState.normal)
                // change button width
                for constraint in self.startSurveyButton.constraints {
                    if(constraint.firstAttribute == NSLayoutAttribute.width) {
                        constraint.constant = 160.0
                    }
                }
            }else {
                if(self.validateYourRiskSurvey().count == 0) {
                    self.startSurveyButton.isHidden = true
                    // set button title
                    self.startSurveyButton.setTitle("Next", for: UIControlState.normal)
                    // change button width
                    for constraint in self.startSurveyButton.constraints {
                        if(constraint.firstAttribute == NSLayoutAttribute.width) {
                            constraint.constant = 100.0
                        }
                    }
                    if(!ApplicationDataModel.sharedInstance.isYourRiskSurveyResponseReceived()) {
                        self.runSyncProcess()
                    }
                }else {
                    self.startSurveyButton.isHidden = true
                }
            }
        }
        if(ApplicationDataModel.sharedInstance.getValuesSurveyCompleted()) {
            let tabs = self.tabBarController?.tabBar.items
            let summaryTab = tabs![3]
            summaryTab.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.reloadData()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourRiskCell", for: indexPath) as! CommonTableViewCell
        
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
        }
        if(indexPath.row == 0) {
            // BUILD CHART
            var chart: UIView!
            if(self.isSyncProcessRunning) {
                cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
                chart = self.buildLoader(frameWidth: cell.cellContentView.frame.width)
            }else {
                // set cell background color
                cell.backgroundColor = UIColor.white
                // check if response successfully received
                if(ApplicationDataModel.sharedInstance.isYourRiskSurveyResponseReceived()) {
                    let riskResponse = ApplicationDataModel.sharedInstance.getYourRiskSurveyResponse()
                    chart = self.buildChart(percent: Int(riskResponse["absrisk5yearperc"]!*10), chartWidth: cell.cellContentView.frame.width)
                }else {
                    chart = self.buildChart(percent: 0, chartWidth: cell.cellContentView.frame.width)
                }
            }
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
            // set cell color
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            if(!self.isSyncProcessRunning) {
                // BUILD TEXT CONTENT
                // build view
                var info: UIView!
                if(ApplicationDataModel.sharedInstance.isYourRiskSurveyResponseReceived()) {
                    let riskResponse = ApplicationDataModel.sharedInstance.getYourRiskSurveyResponse()
                    info = self.buildFooter(frameWidth: cell.cellContentView.frame.width, riskPercent: Int(riskResponse["avgrisk5yearperc"]!*10))
                }else {
                    info = self.buildFooter(frameWidth: cell.cellContentView.frame.width, riskPercent: 0)
                }
                // get view height
                var infoHeight:CGFloat = 0.0
                for constraint in info.constraints {
                    if(constraint.firstAttribute == NSLayoutAttribute.height) {
                        infoHeight = constraint.constant
                    }
                }
                // add content
                cell.cellContentView.addSubview(info)
                // check if valid
                var hasErrors = false
                if(ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
                    if(self.validateYourRiskSurvey().count > 0) {
                        hasErrors = true
                    }
                }
                if(ApplicationDataModel.sharedInstance.isYourRiskSurveyResponseReceived() || hasErrors == true) {
                    // add reset values button
                    let buttonX = (cell.cellContentView.frame.width / 2) - 70.0
                    var buttonY = infoHeight + 10.0
                    let resetButton = UIButton.init(frame: CGRect.init(x: buttonX, y: buttonY, width: 140.0, height: 30))
                    resetButton.setTitle("Reset Selections", for: .normal)
                    resetButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Light", size: 18.0)
                    resetButton.setTitleColor(UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0), for: .normal)
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(YourRiskViewController.resetValuesAction(_:)))
                    resetButton.addGestureRecognizer(gesture)
                    cell.cellContentView.addSubview(resetButton)
                    buttonY = buttonY + resetButton.frame.height
                    // set container height by content
                    cell.cellContentViewHeight.constant = buttonY
                }else {
                    // set container height by content
                    cell.cellContentViewHeight.constant = infoHeight
                }
                // set chart relational constraints
                let constraintCenterX = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
                let constraintCenterY = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
                NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
            }else {
                cell.cellContentViewHeight.constant = 10.0
            }
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
            if(!ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
                headerLabel.text = "Your Decisions"
                headerLabel.font = UIFont(name: "Georgia", size: 30.0)
            }else {
                if(self.validateYourRiskSurvey().count == 0) {
                    headerLabel.text = "?"
                    headerLabel.font = UIFont(name: "Georgia", size: 60.0)
                }else {
                    headerLabel.text = "Your Risk - Higher Than Average"
                    headerLabel.font = UIFont(name: "Georgia", size: 30.0)
                }
            }
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
            currentY = currentY + 10.0
            // add icon1
            let icon1 = UIImageView(image: UIImage(named: "Chart Figure"))
            icon1.frame = CGRect(x: 0, y: currentY+3.0, width: 9.0, height: 15.0)
            icon1.alpha = 0.5
            returnView.addSubview(icon1)
            // add label1
            let label1 = UILabel()
            label1.textAlignment = NSTextAlignment.left
            label1.numberOfLines = 0
            label1.text = "In the next 5 years, 992 will not get breast cancer"
            label1.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
            label1.frame = CGRect(x: 20.0, y: currentY, width: chartWidth-20.0, height: label1.getLabelHeight(byWidth: chartWidth-20.0))
            label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label1)
            currentY = currentY + label1.frame.height + 7.0
            // add icon2
            let icon2 = UIImageView(image: UIImage(named: "Chart Figure Active"))
            icon2.frame = CGRect(x: 0, y: currentY+3.0, width: 9.0, height: 15.0)
            returnView.addSubview(icon2)
            // add label2
            let label2 = UILabel()
            label2.textAlignment = NSTextAlignment.left
            label2.numberOfLines = 0
            label2.text = "In the next 5 years, 8 will get breast cancer"
            label2.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
            label2.frame = CGRect(x: 20.0, y: currentY, width: chartWidth-20.0, height: label2.getLabelHeight(byWidth: chartWidth-20.0))
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
    
    func buildLoader(frameWidth: CGFloat) -> UIView {
        
        // Draw chart
        let returnView = UIView()
        let frameHeight: CGFloat = 100.0
        returnView.translatesAutoresizingMaskIntoConstraints = false
        
        let loader = UIActivityIndicatorView.init(frame: CGRect(x: frameWidth/2-20.0, y: frameHeight/2-20.0, width: 40.0, height: 40.0))
        loader.activityIndicatorViewStyle = .gray
        loader.startAnimating()
        returnView.addSubview(loader)
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameHeight)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        
        return returnView
    }
    
    
    func buildFooter(frameWidth: CGFloat, riskPercent: Int) -> UIView {
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
            label2.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
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
            label4.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
            label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label4)
            currentY = currentY + label4.frame.height + 10.0
            // add label5
            let label5 = UILabel()
            label5.textAlignment = NSTextAlignment.left
            label5.numberOfLines = 0
            label5.text = "Now that you know your breast cancer risk, let's talk about mammograms."
            label5.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
            label5.frame = CGRect(x: 0, y: currentY, width: frameWidth, height: label5.getLabelHeight(byWidth: frameWidth))
            label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
            returnView.addSubview(label5)
            currentY = currentY + label5.frame.height + 20.0
        }else {
            if(!ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
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
            }else {
                // RESPONCE HAS NOT BEEN RECEIVED
                if(self.validateYourRiskSurvey().count == 0) {
                    currentY = currentY + 40.0
                    let label1 = UILabel()
                    label1.textAlignment = NSTextAlignment.center
                    label1.numberOfLines = 0
                    label1.text = "Thanks for completing the survey! Unfortunately, we have not received your results because of internet connection error. Please, try check late."
                    label1.font = UIFont(name:"HelveticaNeue-Light", size: 18.0)
                    label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth-40.0, height: label1.getLabelHeight(byWidth: frameWidth-40.0))
                    label1.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
                    returnView.addSubview(label1)
                    currentY = currentY + label1.frame.height
                }else {
                    // label 2
                    let label1 = UILabel()
                    label1.textAlignment = NSTextAlignment.left
                    label1.numberOfLines = 0
                    let errorArray = self.validateYourRiskSurvey()
                    label1.text = errorArray.joined(separator: " ")
                    label1.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
                    label1.frame = CGRect(x: 0.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
                    label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
                    returnView.addSubview(label1)
                    currentY = currentY + label1.frame.height + 20.0
                    // label 2
                    let label2 = UILabel()
                    label2.textAlignment = NSTextAlignment.left
                    label2.numberOfLines = 0
                    label2.text = "Breast ScreeningDecisions is designed for women at low to average risk of breast cancer. Based on the answers you've provided, your risk of breast cancer may be higher than average. If this is correct, then annual mammograms are recommended for you. In some women, additional screening may be indicated."
                    label2.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
                    label2.frame = CGRect(x: 0.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
                    label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
                    returnView.addSubview(label2)
                    currentY = currentY + label2.frame.height + 20.0
                    // label 3
                    let label3 = UILabel()
                    label3.textAlignment = NSTextAlignment.left
                    label3.numberOfLines = 0
                    label3.text = "Instead of using this tool to make a decision about screening mammography, you should talk to your doctor about your medical history and family history of breast cancer."
                    label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
                    label3.frame = CGRect(x: 0.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
                    label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
                    returnView.addSubview(label3)
                    currentY = currentY + label3.frame.height + 20.0
                    // label 4
                    let label4 = UILabel()
                    label4.textAlignment = NSTextAlignment.left
                    label4.numberOfLines = 0
                    label4.text = "If this is incorrect, you can change your answers by pressing button below."
                    label4.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
                    label4.frame = CGRect(x: 0.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
                    label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
                    returnView.addSubview(label4)
                    currentY = currentY + label4.frame.height + 20.0
                }
            }

        }
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    @IBAction func startSurvey(_ sender: Any) {
        if(ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
            performSegue(withIdentifier: "unwindToScreening", sender: nil)
        }else {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            let taskViewController = ORKTaskViewController(task: SurveyTasks.yourRiskSurveyTask, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true, completion: nil)
        }
        
    }
    
    func resetValuesAction(_ sender:UITapGestureRecognizer){
        // change status bar colors to default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let taskViewController = ORKTaskViewController(task: SurveyTasks.yourRiskSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func validateYourRiskSurvey() -> [String] {
        let errorMessage = [
            "hyperPlasia": "According to the information you provided, you were previously diagnosed with atypical ductal hyperplasia of the breast.",
            "hereditaryOver50": "According to the information you provided, you have a mother, sister or daughter who was diagnosed with breast cancer before age 50.",
            "general": "According to the information you provided, your risk of developing breast cancer may be higher than average. Annual mammograms are recommended for women like you.",
            "hereditaryOvarian": "According to the information you provided, you have a mother, sister or daughter who was diagnosed with ovarian cancer.",
            "previousBreastCancer": "According to the information you provided, you were previously diagnosed with breast cancer.",
            "DCISLCIS": "According to the information you provided, you were diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS) of the breast.",
            "BRCA1BRCA2": "According to the information you provided, you carry a genetic mutation for the BRCA1 or BRCA2 gene.",
            "radiationTherapy": "According to the information you provided, you previously had radiation therapy to the chest for another medical condition.",
            "hereditaryOver50No": "Based on this information, your risk of developing breast cancer in the next 5 years is 2%, and your lifetime risk of developing breast cancer is 18.1%. This may be higher than the average risk for women of your age and ethnicity. If this is correct, then annual mammograms are recommended for you. In some women, additional screening may be indicated."
        ]
        var error: [String] = []
        let objResearchKitHelper = ResearchKitHelper()
        var answer: String!
        
        if(ApplicationDataModel.sharedInstance.getYourRiskSurveyCompleted()) {
            let taskResult = ApplicationDataModel.sharedInstance.getYourRiskTaskResult()
            
            // Question 6: Have you ever been diagnosed with atypical ductal hyperplasia of the breast?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question6")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["hyperPlasia"]!)
                }
            }
            // Question 7: How many of your first-degree relatives (mother, sisters, daughters) have had breast cancer?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question7")
            if(answer != nil) {
                if(answer == "1") {
                    answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question7_1")
                    if(answer != nil) {
                        if(answer == "YES") {
                            error.append(errorMessage["hereditaryOver50"]!)
                        }else {
                            error.append(errorMessage["hereditaryOver50No"]!)
                        }
                    }
                }
            }
            // Question 8: Have any of your first degree relatives (mother, sisters, daughters) had ovarian cancer?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question8")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["hereditaryOvarian"]!)
                }
            }
            // Question 9: Have you ever been diagnosed with breast cancer?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question9")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["previousBreastCancer"]!)
                }
            }
            // Question 10: Have you ever been diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS)?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question10")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["DCISLCIS"]!)
                }
            }
            // Question 11: Have you ever been told that you carry a genetic mutation for the BRCA1 or BRCA2 gene?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question11")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["BRCA1BRCA2"]!)
                }
            }
            // Question 12: Have you ever had radiation therapy to the chest for another medical condition?
            answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question12")
            if(answer != nil) {
                if(answer == "YES") {
                    error.append(errorMessage["radiationTherapy"]!)
                }
            }
        }
        return error
    }
    
}

extension YourRiskViewController: ORKTaskViewControllerDelegate {
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Set status bar color to white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        switch reason {
        case .completed:
            // save result
            ApplicationDataModel.sharedInstance.setYourRiskSurveyTaskResult(data: taskViewController.result)
            ApplicationDataModel.sharedInstance.resetYourRiskSurveyResponse()
            // check if survey answeres match low to average risk level
            if(self.validateYourRiskSurvey().count == 0) {
                // update UI
                self.isSyncProcessRunning = true
                self.tableView.reloadData()
                self.startSurveyButton.isHidden = true
                // Disable tab bars
                let tabs = self.tabBarController?.tabBar.items
                let screeningTab = tabs![1]
                screeningTab.isEnabled = false
                taskViewController.dismiss(animated: true, completion: {() -> Void in
                    self.runSyncProcess()
                })
            }else {
                // update UI
                self.tableView.reloadData()
                self.startSurveyButton.isHidden = true
                // Disable tab bars
                let tabs = self.tabBarController?.tabBar.items
                let screeningTab = tabs![1]
                screeningTab.isEnabled = false
                let valuesTab = tabs![2]
                valuesTab.isEnabled = false
                taskViewController.dismiss(animated: true, completion: nil)
            }
        default:
            print("Not completed!")
            taskViewController.dismiss(animated: true, completion: nil)
        }
        
    }
}
