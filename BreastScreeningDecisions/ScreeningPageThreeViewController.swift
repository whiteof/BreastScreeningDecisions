//
//  ScreeningPageThreeViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/21/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScreeningPageThreeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScreeningPageThreeCell", for: indexPath) as! CommonTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
        }
        if(indexPath.row == 0) {
            // BUILD CHART
            let chart = self.buildHeader(normal: 899, falseNegative: 1, falsePositive: 98, haveBC: 2, chartWidth: (cell.cellContentView.frame.width-40.0))
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
    
    func buildHeader(normal: Int, falseNegative: Int, falsePositive: Int, haveBC: Int, chartWidth: CGFloat) -> UIView {
        
        // Draw chart
        let returnView = UIView()
        
        returnView.translatesAutoresizingMaskIntoConstraints = false
        var currentY: CGFloat = 20.0
        
        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "How well do mammograms perform in women like me?"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 0.0, y: currentY, width: chartWidth, height: label1.getLabelHeight(byWidth: chartWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        
        let figureWidth = CGFloat(chartWidth/50.0-1.0)
        let figureHeight = CGFloat(figureWidth*15.0/9.0)
        let chartHeight = CGFloat((figureHeight+1.0)*20.0)
        let falsePositiveInRow = Int((falsePositive+haveBC)/20)
        
        for j in 0...19 {
            for i in 0...49 {
                var imageName = "Chart Figure"
                var imageAlpha: CGFloat = 0.5
                if(i > (49-falsePositiveInRow)) {
                    imageAlpha = 1.0
                }
                if j == 19 && i < falseNegative {
                    imageName = "Chart Figure Active"
                    imageAlpha = 1.0
                }
                if j == 19 && i > (49-haveBC) {
                    imageName = "Chart Figure Active"
                    imageAlpha = 1.0
                }
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                let x = (figureWidth+1.0)*CGFloat(i)
                let y = (figureHeight+1.0)*CGFloat(j)
                imageView.frame = CGRect(x: x, y: (currentY+y), width: figureWidth, height: figureHeight)
                imageView.alpha = imageAlpha
                returnView.addSubview(imageView)
            }
        }
        currentY = currentY + chartHeight + 10.0
        
        // create disclaimer
        // add label2
        var currentLeftY = currentY
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "900 will have a normal mammogram"
        label2.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label2.frame = CGRect(x: 0, y: currentLeftY, width: (chartWidth/2-10.0), height: label2.getLabelHeight(byWidth: (chartWidth/2-10.0))+10.0)
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        label2.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0), thickness: 0.5)
        returnView.addSubview(label2)
        currentLeftY = currentLeftY + label2.frame.height + 5.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.text = "899 do not have breast cancer "
        label4.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label4.frame = CGRect(x: 10.0, y: currentLeftY, width: (chartWidth/2-20.0), height: label4.getLabelHeight(byWidth: (chartWidth/2-20.0)))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentLeftY = currentLeftY + label4.frame.height + 5.0
        // add label5
        let label5 = UILabel()
        label5.textAlignment = NSTextAlignment.left
        label5.numberOfLines = 0
        label5.text = "1 has breast cancer missed by screening (false negative)"
        label5.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label5.frame = CGRect(x: 10.0, y: currentLeftY, width: (chartWidth/2-20.0), height: label5.getLabelHeight(byWidth: (chartWidth/2-20.0)))
        label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label5)
        currentLeftY = currentLeftY + label5.frame.height + 10.0
        
        // add label3
        var currentRightY = currentY
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "100 will have an abnormal mammogram"
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label3.frame = CGRect(x: (chartWidth/2+10.0), y: currentRightY, width: (chartWidth/2-10.0), height: label3.getLabelHeight(byWidth: (chartWidth/2-10.0))+10.0)
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        label3.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0), thickness: 0.5)
        returnView.addSubview(label3)
        currentRightY = currentRightY + label3.frame.height + 5.0
        // add label6
        let label6 = UILabel()
        label6.textAlignment = NSTextAlignment.left
        label6.numberOfLines = 0
        label6.text = "98 do not have breast cancer (false positive)"
        label6.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label6.frame = CGRect(x: (chartWidth/2+20.0), y: currentRightY, width: (chartWidth/2-10.0), height: label6.getLabelHeight(byWidth: (chartWidth/2-20.0))+10.0)
        label6.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label6)
        currentRightY = currentRightY + label6.frame.height + 5.0
        // add label7
        let label7 = UILabel()
        label7.textAlignment = NSTextAlignment.left
        label7.numberOfLines = 0
        label7.text = "2 have breast cancer caught by screening"
        label7.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label7.frame = CGRect(x: (chartWidth/2+20.0), y: currentRightY, width: (chartWidth/2-10.0), height: label7.getLabelHeight(byWidth: (chartWidth/2-20.0))+10.0)
        label7.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label7)
        currentRightY = currentRightY + label6.frame.height + 5.0
        // set currentY
        if(currentLeftY > currentRightY) {
            currentY = currentLeftY + 10.0
        }else {
            currentY = currentRightY + 10.0
        }
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: chartWidth)
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
        label1.text = "So What Does This Mean?"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "Almost all women your age will have a normal mammogram."
        label2.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.attributedText = UILabel.generateFormattedText(content: [
            ["Almost all abnormal mammograms are not cancer. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["These are false-positive results. The more often you get screened, the greater your chance of ever having a false-positive result. Over 10 years, women who have mammograms every year have a 60% chance of a false-positive result. Women who have mammograms every other year have a 40% chance of a false-positive result.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label3.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.attributedText = UILabel.generateFormattedText(content: [
            ["Some breast cancers may be missed. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["These are false-negative results. When a cancer is missed by a screening mammogram, it is usually found after a woman has symptoms or at a future screening mammogram visit.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label4.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height
        // add label5
        let label5 = UILabel()
        label5.textAlignment = NSTextAlignment.left
        label5.numberOfLines = 0
        label5.text = "By catching some cancers early, before a woman has symptoms, mammograms can reduce the chance of dying from breast cancer. Let's see how."
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
}
