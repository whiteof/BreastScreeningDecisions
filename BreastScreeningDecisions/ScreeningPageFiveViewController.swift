//
//  ScreeningPageFiveViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/21/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScreeningPageFiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScreeningPageFiveCell", for: indexPath) as! CommonTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
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
    
    func buildHeader(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 20.0
        
        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "Summarizing so far"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add image
        let image = UIImageView(image: UIImage.init(named: "Screening Figure"))
        image.frame = CGRect(x: 20.0, y: currentY, width: 50.0, height: 90.0)
        returnView.addSubview(image)
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "You are at low to average risk of developing breast cancer."
        label2.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label2.frame = CGRect(x: 90.0, y: currentY, width: (frameWidth - 70.0), height: label2.getLabelHeight(byWidth: (frameWidth - 70.0)))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Your chance of developing breast cancer in the next 5 years is about 0.8%."
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label3.frame = CGRect(x: 90.0, y: currentY, width: (frameWidth - 70.0), height: label3.getLabelHeight(byWidth: (frameWidth - 70.0)))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height

        if(image.frame.origin.y + image.frame.height) > currentY {
            currentY = image.frame.origin.y + image.frame.height + 10.0
        }else {
            currentY = currentY + 10.0
        }
        
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.text = "This means that out of 1,000 women like you, 8 of them will develop breast cancer in the next 5 years and 992 will not."
        label4.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label4.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth)+20.0)
        label4.layer.addBorder(edge: .top, color: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0), thickness: 0.5)
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height + 20
        
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buildFooter(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 20.0
        
        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "Of 1000 women like you at low to average risk who have screening mammograms, over their lifetime:"
        label1.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.center
        label2.numberOfLines = 0
        label2.text = "Number of Deaths Due to"
        label2.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3 mark
        let label3View = UIView()
        label3View.frame = CGRect(x: 20.0, y: (currentY+2.0), width: 10.0, height: 10.0)
        label3View.backgroundColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label3View)
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Breast Cancer"
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label3.frame = CGRect(x: 40.0, y: currentY, width: (frameWidth/2)-50.0, height: label3.getLabelHeight(byWidth: (frameWidth/2)-50.0))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        // add label4 mark
        let label4View = UIView()
        label4View.frame = CGRect(x: frameWidth/2, y: (currentY+2.0), width: 10.0, height: 10.0)
        label4View.backgroundColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        returnView.addSubview(label4View)
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.text = "Other causes"
        label4.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label4.frame = CGRect(x: (frameWidth/2)+20.0, y: currentY, width: (frameWidth/2)-40.0, height: label4.getLabelHeight(byWidth: (frameWidth/2)-40.0))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height + 10.0

        var row = self.buldChartRow(value: 22, title: "Starting at age 40", width: frameWidth)
        var rowView = row.view
        rowView.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: row.height)
        returnView.addSubview(rowView)
        currentY = currentY + rowView.frame.height + 5.0

        row = self.buldChartRow(value: 23, title: "Starting at age 50", width: frameWidth)
        rowView = row.view
        rowView.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: row.height)
        returnView.addSubview(rowView)
        currentY = currentY + rowView.frame.height + 5.0

        row = self.buldChartRow(value: 24, title: "Starting at age 40", width: frameWidth)
        rowView = row.view
        rowView.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: row.height)
        returnView.addSubview(rowView)
        currentY = currentY + rowView.frame.height + 5.0

        row = self.buldChartRow(value: 25, title: "Starting at age 50", width: frameWidth)
        rowView = row.view
        rowView.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: row.height)
        returnView.addSubview(rowView)
        currentY = currentY + rowView.frame.height + 15.0
        
        // add label
        let label5 = UILabel()
        label5.textAlignment = NSTextAlignment.left
        label5.numberOfLines = 0
        label5.text = "But your decision about having a screening mammogram is not just about the numbers. In the next section, we'll explore your personal values and concerns about breast cancer and screening mammograms."
        label5.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label5.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label5.getLabelHeight(byWidth: frameWidth))
        label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label5)
        currentY = currentY + label5.frame.height
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buldChartRow(value: Int, title: String, width: CGFloat) -> (view: UIView, height: CGFloat)  {
        let returnView = UIView()
        var currentY:CGFloat = 0.0
        
        let title = UILabel()
        title.textAlignment = NSTextAlignment.left
        title.numberOfLines = 0
        title.text = "Starting at age 40"
        title.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        title.frame = CGRect(x: 0.0, y: currentY, width: width, height: title.getLabelHeight(byWidth: width))
        title.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(title)
        currentY = currentY + title.frame.height + 2.0
        
        // add line
        let chartRow = UIView()
        chartRow.frame = CGRect.init(x: 0.0, y: currentY, width: width, height: 20.0)
        chartRow.backgroundColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        chartRow.layer.cornerRadius = 4.0
        let subChartRow = UIView()
        subChartRow.frame = CGRect.init(x: 0.0, y: 0.0, width: (width*CGFloat(value)/1000), height: 20.0)
        subChartRow.backgroundColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        chartRow.addSubview(subChartRow)
        chartRow.clipsToBounds = true
        returnView.addSubview(chartRow)
        currentY = currentY + chartRow.frame.height + 2.0
        
        // add value left
        let valueLeft = UILabel()
        valueLeft.textAlignment = NSTextAlignment.left
        valueLeft.numberOfLines = 1
        valueLeft.text = String(describing: value)
        valueLeft.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        valueLeft.frame = CGRect(x: 0.0, y: currentY, width: width, height: valueLeft.getLabelHeight(byWidth: width))
        valueLeft.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(valueLeft)
        
        // add label7
        let valueCenter = UILabel()
        valueCenter.textAlignment = NSTextAlignment.center
        valueCenter.numberOfLines = 0
        valueCenter.text = String(describing: (1000-value))
        valueCenter.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        valueCenter.frame = CGRect(x: 0.0, y: currentY, width: width, height: valueCenter.getLabelHeight(byWidth: width))
        valueCenter.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(valueCenter)
        currentY = currentY + valueCenter.frame.height
        
        return (returnView, currentY)
    }
    
    @IBAction func goToValuesAction(_ sender: Any) {
        performSegue(withIdentifier: "unwindToValues", sender: nil)
    }
}
