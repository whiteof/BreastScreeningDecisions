//
//  ScreeningPageTwoViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/21/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScreeningPageTwoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScreeningPageTwoCell", for: indexPath) as! CommonTableViewCell
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
        label1.text = "What else do I need to know?"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "There are benefits and harms of screening mammograms for women at any age."
        label2.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Benefits of screening mammograms"
        label3.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label3.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.attributedText = UILabel.generateFormattedText(content: [
            ["Mammograms reduce the chance of dying from breast cancer. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["By finding breast cancer at an early stage, mammograms allow for early cancer treatment that can increase the chance of a cure.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label4.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height + 10.0
        // add label5
        let label5 = UILabel()
        label5.textAlignment = NSTextAlignment.left
        label5.numberOfLines = 0
        label5.text = "• Mammograms are more effective in older than younger women. Women in their 40's tend to have denser breasts, making it more difficult to find breast cancers in women in this age group compared to older women."
        label5.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label5.frame = CGRect(x: 40.0, y: currentY, width: (frameWidth-20.0), height: label5.getLabelHeight(byWidth: (frameWidth-20.0)))
        label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label5)
        currentY = currentY + label5.frame.height + 10.0
        // add label6
        let label6 = UILabel()
        label6.textAlignment = NSTextAlignment.left
        label6.numberOfLines = 0
        label6.text = "• Mammograms do not prevent all breast cancer deaths. Some fast-growing breast cancers may have already spread to other parts of the body by the time they are found by a mammogram."
        label6.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label6.frame = CGRect(x: 40.0, y: currentY, width: (frameWidth-20.0), height: label6.getLabelHeight(byWidth: (frameWidth-20.0)))
        label6.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label6)
        currentY = currentY + label6.frame.height + 20.0

        
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
        label1.text = "Possible harms of screening mammograms"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.attributedText = UILabel.generateFormattedText(content: [
            ["False-positive results. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["A false-positive result occurs when a mammogram is abnormal but there is no cancer. An abnormal mammogram usually requires additional imaging (diagnostic mammogram, ultrasound or MRI) and possibly a breast biopsy. If an abnormal mammogram is not cancer, this additional testing may seem unnecessary, inconvenient and physically uncomfortable.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label2.frame = CGRect(x: 40.0, y: currentY, width: frameWidth-40.0, height: label2.getLabelHeight(byWidth: frameWidth-40.0))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 5.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.attributedText = UILabel.generateFormattedText(content: [
            ["Overdiagnosis and unnecessary treatment. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["Screening mammograms often find slow-growing breast cancers and non-invasive breast cancers. These cancers have a very small chance of causing death, so treating them - with surgery, chemotherapy and radiation - may seem unnecessary. However, it is very difficult to predict whether a cancer will be life-threatening, so almost all cancers that are found will be treated.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label3.frame = CGRect(x: 40.0, y: currentY, width: frameWidth-40.0, height: label3.getLabelHeight(byWidth: frameWidth-40.0))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 5.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.attributedText = UILabel.generateFormattedText(content: [
            ["False-negative results. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["A false-negative result occurs when a mammogram is normal but a woman truly has breast cancer. Mammograms are not perfect. Some breast cancers will be missed by screening.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label4.frame = CGRect(x: 40.0, y: currentY, width: frameWidth-40.0, height: label4.getLabelHeight(byWidth: frameWidth-40.0))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height + 5.0
        // add label5
        let label5 = UILabel()
        label5.textAlignment = NSTextAlignment.left
        label5.numberOfLines = 0
        label5.attributedText = UILabel.generateFormattedText(content: [
            ["Radiation exposure. ": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            ["Mammograms use radiation, but the risk of harm from screening mammograms is extremely low.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label5.frame = CGRect(x: 40.0, y: currentY, width: frameWidth-40.0, height: label5.getLabelHeight(byWidth: frameWidth-40.0))
        label5.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label5)
        currentY = currentY + label5.frame.height + 20.0
        // add label6
        let label6 = UILabel()
        label6.textAlignment = NSTextAlignment.left
        label6.numberOfLines = 0
        label6.text = "It's hard to know who will benefit from mammograms and who will experience harm. What we can tell you is how mammograms perform in women like you and how starting screening at different ages may affect a woman's chance of dying from breast cancer."
        label6.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label6.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label6.getLabelHeight(byWidth: frameWidth))
        label6.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label6)
        currentY = currentY + label6.frame.height
        
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
}
