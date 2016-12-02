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
        
    func getFormattedScaleAnswer(taskResult: ORKTaskResult, stepIdentifier: String) -> Int? {
        let questionStepResult = taskResult.stepResult(forStepIdentifier: stepIdentifier)
        if(questionStepResult != nil) {
            let questionResult = questionStepResult?.firstResult as! ORKScaleQuestionResult
            let answer = questionResult.answer
            if(answer != nil) {
                return answer as? Int
            }else {
                return nil
            }
        }else {
            return nil
        }
    }
    
}
