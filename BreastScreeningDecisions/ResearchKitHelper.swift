//
//  ResearchKitHelper.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import Foundation
import ResearchKit

class ResearchKitHelper {
    
    func dictFromTaskResult(_ taskResult: ORKTaskResult) -> [String: AnyObject]? {
        
        var retDict: [String:AnyObject] = [:]
        retDict["taskRunUUID"] = taskResult.taskRunUUID.uuidString as AnyObject?
        retDict["startDate"] = "\(taskResult.startDate)" as AnyObject?
        retDict["endDate"] = "\(taskResult.endDate)" as AnyObject?
        for result in taskResult.results! {
            if(result.identifier == "ConsentReviewStep") {
                for subResult in (result as! ORKStepResult).results!  {
                    print("---")
                    print(subResult)
                    print("---")
                }
            }
            if let stepResult = result as? ORKStepResult {
                let dictResult = dictFromStepResult(stepResult)
                if(dictResult["value"] != nil) {
                    retDict[stepResult.identifier] = dictResult as AnyObject?
                }
            }
        }
        return [taskResult.identifier : retDict as AnyObject]
        
    }
    func dictFromStepResult(_ stepResult: ORKStepResult) -> [String: AnyObject] {
        var retDict: [String:AnyObject] = [:]
        retDict["startDate"] = "\(stepResult.startDate)" as AnyObject?
        retDict["endDate"] = "\(stepResult.endDate)" as AnyObject?
        for result in stepResult.results! {
            if (result is ORKChoiceQuestionResult) {
                let resultObj = (result as! ORKChoiceQuestionResult).choiceAnswers as AnyObject as! NSArray
                retDict["value"] = resultObj
            }
            //let resultObj = result as! ORKQuestionResult
            //retDict["value"] = "\(resultObj.answer)"
            //retDict["value"] = "\((result as! ORKQuestionResult).stringValue())"
        }
        return retDict
    }
    
}
