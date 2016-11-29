//
//  SummaryViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/17/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit
import ResearchKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar white color
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // remove insent
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01))
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SummaryViewController.handleTap(_:))))
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            if(view.tag != 1) {
                view.removeFromSuperview()
            }else {
                view.isHidden = true
            }
        }
        if(indexPath.row == 0) {
            // build header
            let info = self.buildHeader(frameWidth: (cell.cellContentView.frame.width - 40.0))
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
            
            cell.emailField.isHidden = false
            cell.sendButton.isHidden = false
            cell.sendButton.layer.cornerRadius = 6.0
            cell.sendButton.backgroundColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            cell.sendButton.setTitleColor(UIColor.white, for: .normal)
            cell.emailTopInsent.constant = infoHeight
            
            // set container height by content
            cell.cellContentViewHeight.constant = infoHeight + 100.0
            // add content
            cell.cellContentView.addSubview(info)
            // set chart relational constraints
            let constraintCenterX = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
            let constraintY = NSLayoutConstraint(item: info, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: cell.cellContentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
            NSLayoutConstraint.activate([constraintCenterX, constraintY])
            
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
        label1.text = "Your summary"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let tempHeightLabel = UILabel()
        tempHeightLabel.numberOfLines = 0
        tempHeightLabel.text = "You have completed all sections of Breast ScreeningDecisions."
        tempHeightLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.attributedText = UILabel.generateFormattedText(content: [
            ["You have completed all sections of ": UIFont(name:"HelveticaNeue-Light", size: 16.0)!],
            ["Breast Screening Decisions.": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!]
            ]
        )
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: tempHeightLabel.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "We hope this tool has provided an opportunity to learn about your breast cancer risk and the benefits and harms of breast cancer screening for women like you."
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label3.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 20.0
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buildFooter(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 20.0
        
        // add label1
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "You can keep a copy of this information to save for your records. We encourage you to print it and share with your doctor at your next visit."
        label1.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "Enter email address and press \"Send\" button to get your summary:"
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
    
    @IBAction func resetAppAction(_ sender: Any) {
        let confirmAlert = UIAlertController(title: "Reset Aplication", message: "Please, confirm to reset the application. All saved data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        confirmAlert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (action: UIAlertAction!) in
            confirmAlert.dismiss(animated: true, completion: nil)
            let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Warning! You are trying to reset this application. All content will be erased.\n\n PLEASE ENTER PASSCODE TO CONFIRM", delegate: self) as! ORKPasscodeViewController
            passcodeViewController.restorationIdentifier = "resetPasscodeViewController"
            self.present(passcodeViewController, animated: true, completion: nil)
        }))
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            confirmAlert.dismiss(animated: true, completion: nil)
        }))
        present(confirmAlert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToSummary(_ segue: UIStoryboardSegue) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sendEmailAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func handleTap(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
}

extension SummaryViewController: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        ApplicationDataModel.sharedInstance.removeUserData()
        ORKPasscodeViewController.removePasscodeFromKeychain()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        performSegue(withIdentifier: "unwindToIntro", sender: self)
    }
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
}
