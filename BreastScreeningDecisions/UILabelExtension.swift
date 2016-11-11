//
//  UILabelExtension.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func getLabelHeightByWidth() -> CGFloat {
        let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = 0
        tempLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tempLabel.font = self.font
        tempLabel.text = self.text
        tempLabel.sizeToFit()
        return tempLabel.frame.height
    }
    
}
