//
//  SurveyTasks.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import ResearchKit

class SurveyTasks {
    
    static let initialSurveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        // Instro step
        let instroStep = ORKInstructionStep(identifier: "step0")
        instroStep.title = "This is an example of Initial Survey"
        instroStep.text = "Please take this survey seriously, even in fact it's demo. Your answers can help us to serve you better!"
        steps += [instroStep]
        
        // Step 1
        let step1TextChoices = [
            ORKTextChoice(text: "Mobile application", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Online web survey sent by email", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Printed questionary", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let step1AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: step1TextChoices)
        let step1 = ORKQuestionStep(identifier: "step1", title: "What kind of tools do you use to gather your data?", answer: step1AnswerFormat)
        steps += [step1]
        
        // Step 2
        let step2AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Completely\nSatisfied", minimumValueDescription: "Completely\nUnsatisfied")
        let step2 = ORKQuestionStep(identifier: "step2", title: "Rate 1 to 10 how are you satisfied with the tools you use to gather your data.", answer: step2AnswerFormat)
        steps += [step2]
        
        // Step 3
        let step3AnswerFormat = ORKTextAnswerFormat(maximumLength: 0)
        let step3 = ORKQuestionStep(identifier: "step3", title: "What would you change/add to the tools you use to improve data gathering process?", answer: step3AnswerFormat)
        steps += [step3]
        
        // Step 4
        let step4TextChoices = [
            ORKTextChoice(text: "Online web based platform", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "MS Excel", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Manually handle printed questionary", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let step4AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: step4TextChoices)
        let step4 = ORKQuestionStep(identifier: "step4", title: "What tools do you use to handle and analyze your data?", answer: step4AnswerFormat)
        steps += [step4]
        
        // Step 5
        let step5AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Completely\nSatisfied", minimumValueDescription: "Completely\nUnsatisfied")
        let step5 = ORKQuestionStep(identifier: "step5", title: "Rate 1 to 10 how are you satisfied with the tools you use to analyze your data.", answer: step5AnswerFormat)
        steps += [step5]
        
        // Step 6
        let step6AnswerFormat = ORKTextAnswerFormat(maximumLength: 0)
        let step6 = ORKQuestionStep(identifier: "step6", title: "What would you change/add to the tools you use to improve data handling process?", answer: step6AnswerFormat)
        steps += [step6]
        
        // Step 7
        let step7AnswerFormat = ORKTextAnswerFormat(maximumLength: 0)
        let step7 = ORKQuestionStep(identifier: "step7", title: "What tools do you use to develop/design your research?", answer: step7AnswerFormat)
        steps += [step7]
        
        // Step 8
        let step8AnswerFormat = ORKAnswerFormat.decimalAnswerFormat(withUnit: NSLocalizedString("patients", comment: ""))
        let step8 = ORKQuestionStep(identifier: "step8", title: "What is the approximate number of participants you need to make your survey successful?", answer: step8AnswerFormat)
        steps += [step8]
        
        // Step 9
        let step9TextChoices = [
            ORKTextChoice(text: "Heart rate", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Current weather", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Current location", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Current time", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let step9AnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: step9TextChoices)
        let step9 = ORKQuestionStep(identifier: "step9", title: "If it would be possible what kind of information would you add to your survey?", answer: step9AnswerFormat)
        steps += [step9]
        
        // Step 10
        let step10AnswerFormat = ORKBooleanAnswerFormat()
        let step10 = ORKQuestionStep(identifier: "step10", title: "Do you know that an iPhone allows to retrieve the following information: heart rate, weather, location, time, daily distance patient walked and other important data?", answer: step10AnswerFormat)
        steps += [step10]
        
        // Step 11
        let step11AnswerFormat = ORKBooleanAnswerFormat()
        let step11 = ORKQuestionStep(identifier: "step11", title: "Do you know there are number of devices can be connected to an iPhone allowing measure: blood pressure, sugar blood analyze, heart rate during all the day?", answer: step11AnswerFormat)
        steps += [step11]
        
        // Completion step
        let completionStep = ORKCompletionStep(identifier: "step12")
        completionStep.title = "Thank you for you time!"
        completionStep.text = "Thank you for completing this survey. Follow Up survey will be available in 5 minutes. You will be notified by iOS push notification, thus you can close this app, if you want."
        steps += [completionStep]
        
        return ORKOrderedTask(identifier: "initialSurveyTask", steps: steps)
    }()
    
    static let followUpSurveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        // Instro step
        let instroStep = ORKInstructionStep(identifier: "step0")
        instroStep.title = "This is an example of Follow Up Survey"
        instroStep.text = "Please take this survey seriously, even in fact it's demo. Your answers can help us to serve you better!"
        steps += [instroStep]
        
        return ORKOrderedTask(identifier: "followUpSurveyTask", steps: steps)
    }()
    
    static let resumeSurveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        // Instro step
        let instroStep = ORKInstructionStep(identifier: "step0")
        instroStep.title = "This is an example of Resume Survey"
        instroStep.text = "Please take this survey seriously, even in fact it's demo. Your answers can help us to serve you better!"
        steps += [instroStep]
        
        return ORKOrderedTask(identifier: "resumeSurveyTask", steps: steps)
    }()
    
}
