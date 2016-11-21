//
//  ScreeningViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/21/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScreeningPageOneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScreeningPageOneCell", for: indexPath) as! CommonTableViewCell
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
            let info = self.buildInfo(frameWidth: (cell.cellContentView.frame.width - 40.0))
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
    
    func buildInfo(frameWidth: CGFloat) -> UIView {
        let returnView = UIView()
        var currentY: CGFloat = 20.0

        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "What is a screening mammogram?"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.attributedText = UILabel.generateFormattedText(content: [
                ["A screening mammogram":UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
                [" is an x-ray that looks for breast cancer in a healthy woman who has no signs or symptoms of breast cancer.":UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Screening mammograms do not prevent breast cancer. Their purpose is to detect breast cancer before it is large enough to be felt or cause symptoms. If you have any breast symptoms, you should see your doctor."
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label3.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.attributedText = UILabel.generateFormattedText(content: [
            ["A diagnostic mammogram": UIFont(name:"HelveticaNeue-Bold", size: 16.0)!],
            [" is performed when a woman feels a lump or has breast symptoms or if her screening mammogram is abnormal.": UIFont(name:"HelveticaNeue-Light", size: 16.0)!]
            ]
        )
        label4.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    

}
