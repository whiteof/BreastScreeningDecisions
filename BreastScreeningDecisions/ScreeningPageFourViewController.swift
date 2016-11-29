//
//  ScreeningPageFourViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/21/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit

class ScreeningPageFourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var header1: UILabel!
    var header2: UILabel!
    var values: [Int:Int]!
    var buttons = [
        1: UIView(),
        2: UIView(),
        3: UIView(),
        4: UIView()
    ]
    var figures: [Int:UIImageView] = [:]

    
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
        self.values = [
            1: 22,
            2: 23,
            3: 24,
            4: 25
        ]
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScreeningPageFourCell", for: indexPath) as! CommonTableViewCell
        cell.cellContentView.translatesAutoresizingMaskIntoConstraints = false
        
        // remove content
        for view in cell.cellContentView.subviews {
            view.removeFromSuperview()
        }
        
        if(indexPath.row == 0) {
            // BUILD CHART
            let chart = self.buildHeader(number: self.values[1]!, chartWidth: (cell.cellContentView.frame.width-40.0))
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

    func buildHeader(number: Int, chartWidth: CGFloat) -> UIView {
        
        // Draw chart
        let returnView = UIView()
        
        returnView.translatesAutoresizingMaskIntoConstraints = false
        var currentY: CGFloat = 20.0
        
        // add header
        let label1 = UILabel()
        label1.textAlignment = NSTextAlignment.left
        label1.numberOfLines = 0
        label1.text = "What difference does mammography make?"
        label1.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label1.frame = CGRect(x: 0.0, y: currentY, width: chartWidth, height: label1.getLabelHeight(byWidth: chartWidth))
        label1.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "If 1,000 women your age at low to average risk of breast cancer have mammograms:"
        label2.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
        label2.frame = CGRect(x: 0.0, y: currentY, width: chartWidth, height: label2.getLabelHeight(byWidth: chartWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        
        let figureWidth = CGFloat(chartWidth/50.0-1.0)
        let figureHeight = CGFloat(figureWidth*15.0/9.0)
        let chartHeight = CGFloat((figureHeight+1.0)*20.0)
        var headerY = currentY + (figureHeight*5)
        
        for j in 0...19 {
            for i in 0...49 {
                var imageName = "Chart Figure"
                var imageAlpha: CGFloat = 0.2
                if j == 19 && i < number {
                    imageName = "Chart Figure Active"
                    imageAlpha = 1.0
                }
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                let x = (figureWidth+1.0)*CGFloat(i)
                let y = (figureHeight+1.0)*CGFloat(j)
                imageView.frame = CGRect(x: x, y: (currentY+y), width: figureWidth, height: figureHeight)
                imageView.alpha = imageAlpha
                if j == 19 {
                    self.figures[i+1] = imageView
                }
                returnView.addSubview(imageView)
            }
        }
        currentY = currentY + chartHeight + 10.0

        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Press on the different screening schedules below to learn the benefit of screening:"
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 14.0)
        label3.frame = CGRect(x: 0.0, y: currentY, width: chartWidth, height: label3.getLabelHeight(byWidth: chartWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        
        // add text over
        var headerLabel = UILabel()
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.numberOfLines = 0
        headerLabel.text = "\(self.values[1]!) women will die of breast cancer"
        headerLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)
        headerLabel.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
        headerLabel.frame = CGRect(x: 20.0, y: headerY, width: chartWidth-40.0, height: headerLabel.getLabelHeight(byWidth: chartWidth-40.0))
        headerLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerLabel.layer.shadowOpacity = 0.2
        headerLabel.layer.shadowRadius = 4
        self.header1 = headerLabel
        returnView.addSubview(headerLabel)
        headerY = headerY + headerLabel.frame.height + 10.0

        headerLabel = UILabel()
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.numberOfLines = 0
        headerLabel.text = "\(1000-self.values[1]!) women will die of other causes"
        headerLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)
        headerLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        headerLabel.frame = CGRect(x: 20.0, y: headerY, width: chartWidth-40.0, height: headerLabel.getLabelHeight(byWidth: chartWidth-40.0))
        headerLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerLabel.layer.shadowOpacity = 0.2
        headerLabel.layer.shadowRadius = 4
        self.header2 = headerLabel
        returnView.addSubview(headerLabel)
        
        
        // add button
        var button = self.buildButton(width: (chartWidth/2)-20.0, title: "Every year starting at age 40", tagNum: 1)
        var buttonView = button.view
        buttonView.frame = CGRect(x: 0.0, y: currentY, width: (chartWidth/2)-10.0, height: button.height+10.0)
        buttonView.layer.addBorder(edge: .right, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        buttonView.layer.addBorder(edge: .bottom, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        for view in buttonView.subviews {
            if let image = view as? UIImageView {
                image.tintColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            }
            if let label = view as? UILabel {
                label.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            }
        }
        self.buttons[1] = buttonView
        returnView.addSubview(buttonView)

        // add button
        button = self.buildButton(width: (chartWidth/2)-20.0, title: "Every year starting at age 50", tagNum: 2)
        buttonView = button.view
        buttonView.frame = CGRect(x: (chartWidth/2)+10, y: currentY, width: (chartWidth/2)-10.0, height: button.height+10.0)
        buttonView.layer.addBorder(edge: .right, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        buttonView.layer.addBorder(edge: .bottom, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        self.buttons[2] = buttonView
        returnView.addSubview(buttonView)
        currentY = currentY + buttonView.frame.height + 10.0

        // add button
        button = self.buildButton(width: (chartWidth/2)-20.0, title: "Every other year starting at age 40", tagNum: 3)
        buttonView = button.view
        buttonView.frame = CGRect(x: 0.0, y: currentY, width: (chartWidth/2)-10.0, height: button.height+10.0)
        buttonView.layer.addBorder(edge: .right, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        buttonView.layer.addBorder(edge: .bottom, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        self.buttons[3] = buttonView
        returnView.addSubview(buttonView)
        
        // add button
        button = self.buildButton(width: (chartWidth/2)-20.0, title: "Every other year starting at age 50", tagNum: 4)
        buttonView = button.view
        buttonView.frame = CGRect(x: (chartWidth/2)+10, y: currentY, width: (chartWidth/2)-10.0, height: button.height+10.0)
        buttonView.layer.addBorder(edge: .right, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        buttonView.layer.addBorder(edge: .bottom, color: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0), thickness: 0.5)
        self.buttons[4] = buttonView
        returnView.addSubview(buttonView)
        currentY = currentY + buttonView.frame.height + 10.0
        
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
        label1.text = "While screening mammograms can't prevent breast cancer, they can reduce your chance of dying from breast cancer. The benefit of screening depends on when you start and how often you have a screening mammogram."
        label1.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label1.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label1.getLabelHeight(byWidth: frameWidth))
        label1.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label1)
        currentY = currentY + label1.frame.height + 10.0
        // add label2
        let label2 = UILabel()
        label2.textAlignment = NSTextAlignment.left
        label2.numberOfLines = 0
        label2.text = "So What Does This Mean?"
        label2.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label2.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label2.getLabelHeight(byWidth: frameWidth))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "Starting screening earlier and more often can lower your chance of dying from breast cancer. However, this benefit is smaller than many people think. Whether you have mammograms every year or every other year, the difference between starting at age 40 vs. age 50 is 1 fewer death from breast cancer per 1,000 women. Whether you start having mammograms at age 40 or age 50, the difference between screening every year vs. every other year is 2 fewer deaths from breast cancer per 1,000 women."
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label3.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label3.getLabelHeight(byWidth: frameWidth))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        // add label4
        let label4 = UILabel()
        label4.textAlignment = NSTextAlignment.left
        label4.numberOfLines = 0
        label4.text = "We've told you a lot so far. Let's see if we can summarize it for you."
        label4.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label4.frame = CGRect(x: 20.0, y: currentY, width: frameWidth, height: label4.getLabelHeight(byWidth: frameWidth))
        label4.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label4)
        currentY = currentY + label4.frame.height
        
        
        let parentConstraintWidth = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: frameWidth)
        let parentConstraintHeight = NSLayoutConstraint(item: returnView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: currentY)
        NSLayoutConstraint.activate([parentConstraintWidth, parentConstraintHeight])
        
        return returnView
    }
    
    func buildButton(width: CGFloat, title: String, tagNum: Int) -> (view: UIView, height: CGFloat) {
        let returnView = UIView()
 
        // image
        let origImage = UIImage(named: "Screening Button")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        let image = UIImageView(image: tintedImage)
        image.tintColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
        image.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        returnView.addSubview(image)
        
        // titile
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.text = title
        label.font = UIFont(name:"HelveticaNeue-Light", size: 12.0)
        label.frame = CGRect(x: 50.0, y: 0.0, width: width-50.0, height: label.getLabelHeight(byWidth: width-50.0))
        label.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        returnView.addSubview(label)
        
        var height:CGFloat = 0.0
        if(image.frame.height > label.frame.height) {
            height = image.frame.height
        }else {
            height = label.frame.height
        }
        
        // set tag
        returnView.tag = tagNum
        
        // add action
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ScreeningPageFourViewController.changeValuesAction(_:)))
        returnView.addGestureRecognizer(gesture)
        
        return (returnView, height)
    }
    
    func changeValuesAction(_ sender:UITapGestureRecognizer){
        let tagNum = sender.view?.tag
        // update values
        let value = self.values[tagNum!]!
        self.header1.text = "\(value) women will die of breast cancer"
        self.header2.text = "\(1000-value) women will die of other causes"
        // set all buttons to default
        for button in self.buttons {
            for view in button.value.subviews {
                if let image = view as? UIImageView {
                    image.tintColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
                }
                if let label = view as? UILabel {
                    label.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
                }
            }
        }
        // update button view
        let buttonView = sender.view!
        for view in buttonView.subviews {
            if let image = view as? UIImageView {
                image.tintColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            }
            if let label = view as? UILabel {
                label.textColor = UIColor(red: 185/255, green: 29/255, blue: 107/255, alpha: 1.0)
            }
        }
        // update chart
        for imageView in self.figures {
            imageView.value.image = UIImage(named: "Chart Figure")
            imageView.value.alpha = 0.2
        }
        for i in 1...value {
            let imageView = self.figures[i]!
            imageView.image = UIImage(named: "Chart Figure Active")
            imageView.alpha = 1.0
        }
    }
    
}
