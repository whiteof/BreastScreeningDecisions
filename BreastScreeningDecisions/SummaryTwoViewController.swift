//
//  SummaryTwoViewController.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 12/13/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import UIKit
import ResearchKit

class SummaryTwoViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    var zooming = false
    var maxHeaderHeight: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "summary", withExtension: "pdf")
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
        
        self.webView.scrollView.delegate = self
     
        // add content to header view
        let width = self.headerView.frame.width-40.0
        var currentY: CGFloat = 0.0
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
        label2.frame = CGRect(x: 20.0, y: currentY, width: width, height: tempHeightLabel.getLabelHeight(byWidth: width))
        label2.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.headerView.addSubview(label2)
        currentY = currentY + label2.frame.height + 10.0
        // add label3
        let label3 = UILabel()
        label3.textAlignment = NSTextAlignment.left
        label3.numberOfLines = 0
        label3.text = "We hope this tool has provided an opportunity to learn about your breast cancer risk and the benefits and harms of breast cancer screening for women like you."
        label3.font = UIFont(name:"HelveticaNeue-Light", size: 16.0)
        label3.frame = CGRect(x: 20.0, y: currentY, width: width, height: label3.getLabelHeight(byWidth: width))
        label3.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.headerView.addSubview(label3)
        currentY = currentY + label3.frame.height + 10.0
        
        self.headerHeight.constant = currentY
        self.maxHeaderHeight = currentY
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.loader.stopAnimating()
        self.loader.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(!self.zooming) {
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < self.maxHeaderHeight) {
                self.headerHeight.constant = self.maxHeaderHeight - scrollView.contentOffset.y
            }
            if (scrollView.contentOffset.y > self.maxHeaderHeight) {
                self.headerHeight.constant = 0.0
            }
            if (scrollView.contentOffset.y < 0.1) {
                self.headerHeight.constant = self.maxHeaderHeight
            }
        }
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.zooming = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.zooming = false
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < self.maxHeaderHeight) {
                self.headerHeight.constant = self.maxHeaderHeight - scrollView.contentOffset.y
            }
            if (scrollView.contentOffset.y > self.maxHeaderHeight) {
                self.headerHeight.constant = 0.0
            }
            if (scrollView.contentOffset.y < 0.1) {
                self.headerHeight.constant = self.maxHeaderHeight
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
        
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
    
    @IBAction func printAction(_ sender: Any) {
        let url = self.webView.request?.url
        let pic = UIPrintInteractionController.shared
        let printInfo : UIPrintInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = UIPrintInfoOutputType.general
        printInfo.jobName = (url?.absoluteString)!
        pic.printInfo = printInfo
        pic.printFormatter = self.webView.viewPrintFormatter()
        pic.present(animated: true, completionHandler: nil)
    }
    
    @IBAction func unwindToSummary(_ segue: UIStoryboardSegue) {
    }

}

extension SummaryTwoViewController: ORKPasscodeDelegate {
    func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
        ApplicationDataModel.sharedInstance.removeUserData()
        ORKPasscodeViewController.removePasscodeFromKeychain()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        performSegue(withIdentifier: "unwindToIntro", sender: self)
    }
    func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    }
}
