//
//  ValuesViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/17/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit
import ResearchKit

class ValuesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var values:[Float] = []
    let titles = [
        "I'm willing to do anything to detect breast cancer as early as possible.",
        "Screening mammograms are painful and inconvenient.",
        "I only want to have mammograms if I am at high risk for breast cancer.",
        "I want my doctor to tell me when to have mammograms.",
        "I have enough information to make a decision about screening mammograms.",
        "Making a decision about when to start and how often to have mammograms is stressful.",
        "How worried are you about getting breast cancer?",
        "How concerned are you about the possible harms of screening mammograms?"
    ]
    
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
        
        // set values
        self.values = ApplicationDataModel.sharedInstance.getValuesSurveyData()
        
        if(self.values.count == 0) {
            // remove separator
            self.tableView.separatorStyle = .none
            // update button
            self.nextButton.setTitle("Set Values", for: .normal)
        }else {
            // set separator
            self.tableView.separatorStyle = .singleLine
            // update button
            self.nextButton.setTitle("Next", for: .normal)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.values.count == 0) {
            return 2
        }else {
            return self.values.count + 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ValuesCell", for: indexPath) as! ValuesTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        // remove content
        for view in cell.cellContentView.subviews {
            if(view.tag == 1) {
                view.removeFromSuperview()
            }
        }
        if(indexPath.row == 0) {
            // hide static content
            for view in cell.cellContentView.subviews {
                view.isHidden = true
            }
            // set cell bg color
            if(self.values.count == 0) {
                cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            }else {
                cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            }
            
            // build header
            let header = self.buildHeader(frameWidth: (cell.cellContentView.frame.width - 40.0))
            header.tag = 1
            // get view height
            var headerHeight:CGFloat = 0.0
            for constraint in header.constraints {
                if(constraint.firstAttribute == NSLayoutAttribute.height) {
                    headerHeight = constraint.constant
                }
            }
            // set container height by content
            cell.cellContentViewHeight.constant = headerHeight
            // add content
            cell.cellContentView.addSubview(header)
            // set chart relational constraints
            let constraintCenterX = NSLayoutConstraint(item: header, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let constraintCenterY = NSLayoutConstraint(item: header, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
        }else {
            if(self.values.count == 0) {
                // hide static content
                for view in cell.cellContentView.subviews {
                    view.isHidden = true
                }
                // set cell color
                cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
                // build footer
                let footer = self.buildFooter(frameWidth: (cell.cellContentView.frame.width - 40.0))
                footer.tag = 1
                // get view height
                var footerHeight:CGFloat = 0.0
                for constraint in footer.constraints {
                    if(constraint.firstAttribute == NSLayoutAttribute.height) {
                        footerHeight = constraint.constant
                    }
                }
                // set container height by content
                cell.cellContentViewHeight.constant = footerHeight
                // add content
                cell.cellContentView.addSubview(footer)
                // set chart relational constraints
                let constraintCenterX = NSLayoutConstraint(item: footer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
                let constraintCenterY = NSLayoutConstraint(item: footer, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
                NSLayoutConstraint.activate([constraintCenterX, constraintCenterY])
            }else {
                // change descriptions
                if(indexPath.row == 7) {
                    cell.minDescriptionLabel.text = "Not At All Worried"
                    cell.maxDescriptionLabel.text = "Extremely Worried"
                }
                if(indexPath.row == 8) {
                    cell.minDescriptionLabel.text = "Not At All Concerned"
                    cell.maxDescriptionLabel.text = "Extremely Concerned"
                }
                
                if(indexPath.row == 9) {
                    // hide static content
                    for view in cell.cellContentView.subviews {
                        view.isHidden = true
                    }
                    // set background
                    cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
                    // add reset values button
                    let buttonX = (cell.cellContentView.frame.width / 2) - 70.0
                    let resetButton = UIButton.init(frame: CGRect.init(x: buttonX, y: 10.0, width: 140.0, height: 30))
                    resetButton.setTitle("Reset Values", for: .normal)
                    resetButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Light", size: 18.0)
                    resetButton.setTitleColor(UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0), for: .normal)
                    resetButton.tag = 1
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(ValuesViewController.resetValuesAction(_:)))
                    resetButton.addGestureRecognizer(gesture)
                    
                    cell.cellContentView.addSubview(resetButton)
                    cell.cellContentViewHeight.constant = 40.0
                }else {
                    // show static content
                    for view in cell.cellContentView.subviews {
                        view.isHidden = false
                    }
                    cell.title.text = self.titles[indexPath.row - 1]
                    cell.progressView.setProgress(self.values[indexPath.row - 1], animated: false)
                    cell.cellContentViewHeight.constant = cell.title.getLabelHeight(byWidth: cell.title.frame.width) + 60.0
                }
            }
        }
        
        return cell
    }

    
    func buildHeader(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 20.0
        
        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "Other things to think about"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "Every woman's feelings and concerns are different, and it may be helpful to think about what's important to you. The statements and questions below will give you a chance to explore your feelings about screening mammograms and breast cancer. There is no right or wrong answer."
        label2.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 20.0
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buildFooter(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 40.0
        
        // add footer
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.center
        label1.numberOfLines = 0
        label1.text = "Press \"Set Values\" button to explore your feelings about screening mammograms and breast cancer."
        label1.font = UIFont(name:"HelveticaNeue-Light", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if(self.values.count == 0) {
            // change status bar colors to default
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            let taskViewController = ORKTaskViewController(task: SurveyTasks.valuesSurveyTask, taskRun: nil)
            taskViewController.delegate = self
            present(taskViewController, animated: true, completion: nil)
        }else {
            performSegue(withIdentifier: "unwindToSummary", sender: nil)
        }
    }
    
    func resetValuesAction(_ sender:UITapGestureRecognizer){
        // change status bar colors to default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let taskViewController = ORKTaskViewController(task: SurveyTasks.valuesSurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToValues(_ segue: UIStoryboardSegue) {
    }
    
}

extension ValuesViewController: ORKTaskViewControllerDelegate {
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Set status bar color to white
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        switch reason {
        case .completed:
            // Enable summary tab
            let tabs = self.tabBarController?.tabBar.items
            let summaryTab = tabs![3]
            summaryTab.isEnabled = true
            
            ApplicationDataModel.sharedInstance.setValuesSurveyTaskResult(data: taskViewController.result)
            self.values = ApplicationDataModel.sharedInstance.getValuesSurveyData()
            self.nextButton.setTitle("Next", for: UIControlState.normal)
            self.tableView.reloadData()
            
            // Delete PDF file if exists
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let filePathString = dir.appendingPathComponent("summary.pdf").path
            if (FileManager.default.fileExists(atPath: filePathString)) {
                let fileManager = FileManager()
                do {
                    try fileManager.removeItem(atPath: filePathString)
                }catch {
                    print("Error removing file!")
                }
            }
            
        default:
            print("Not completed!")
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
