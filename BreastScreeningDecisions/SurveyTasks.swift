//
//  SurveyTasks.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/11/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import ResearchKit

class SurveyTasks {
    
    static let yourRiskSurveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        let step1 = ORKFormStep(identifier: "question1", title: NSLocalizedString("How Old Are You?", comment: ""), text: nil)
        step1.isOptional = false
        let format1 = ORKAnswerFormat.decimalAnswerFormat(withUnit: NSLocalizedString("Your age", comment: ""))
        let item1 = ORKFormItem(identifier: "item1", text: "", answerFormat: format1)
        step1.formItems = [item1]
        steps += [step1]
        
        
        var textChoices = [
            NSLocalizedString("White", comment: ""),
            NSLocalizedString("African American", comment: ""),
            NSLocalizedString("Hispanic", comment: ""),
            NSLocalizedString("Asian or Pacific Islander", comment: ""),
            NSLocalizedString("American Indian or Alaskan Native", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        var choices: [ORKTextChoice] = []
        var i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        var step = ORKFormStep(identifier: "question2", title: NSLocalizedString("What is your race/ethnicity?", comment: ""), text: nil)
        step.isOptional = false
        var format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        var item = ORKFormItem(identifier: "item2", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("7-11", comment: ""),
            NSLocalizedString("12-13", comment: ""),
            NSLocalizedString("14 or Older", comment: ""),
            NSLocalizedString("Don't Know", comment: ""),
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question3", title: NSLocalizedString("How old were you at your first menstrual period?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item3", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question4", title: NSLocalizedString("Have you had any children?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item4", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question5", title: NSLocalizedString("Have you ever had a breast biopsy?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item5", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question6", title: NSLocalizedString("Have you ever been diagnosed with atypical ductal hyperplasia of the breast?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item6", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        
        textChoices = [
            NSLocalizedString("0", comment: ""),
            NSLocalizedString("1", comment: ""),
            NSLocalizedString("More Than 1", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question7", title: NSLocalizedString("How many of your first-degree relatives (mother, sisters, daughters) have had breast cancer?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item7", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question8", title: NSLocalizedString("Have any of your first degree relatives (mother, sisters, daughters) had ovarian cancer?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item8", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question9", title: NSLocalizedString("Have you ever been diagnosed with breast cancer?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item9", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question10", title: NSLocalizedString("Have you ever been diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS)?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item10", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question11", title: NSLocalizedString("Have you ever been told that you carry a genetic mutation for the BRCA1 or BRCA2 gene?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item11", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        textChoices = [
            NSLocalizedString("Yes", comment: ""),
            NSLocalizedString("No", comment: ""),
            NSLocalizedString("Don't Know", comment: "")
        ]
        choices = []
        i = 0
        for textChoice in textChoices {
            i += 1
            choices.append(ORKTextChoice(text: textChoice, value: "choice_\(i)" as NSCoding & NSCopying & NSObjectProtocol))
        }
        step = ORKFormStep(identifier: "question12", title: NSLocalizedString("Have you ever had radiation therapy to the chest for another medical condition?", comment: ""), text: nil)
        step.isOptional = false
        format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: choices)
        item = ORKFormItem(identifier: "item12", text: "", answerFormat: format)
        step.formItems = [item]
        steps += [step]
        
        return ORKOrderedTask(identifier: "followUpSurveyTask", steps: steps)
    }()
    
    static let valuesSurveyTask: ORKOrderedTask = {
        
        var steps = [ORKStep]()
        
        let scaleStepIntro = ORKInstructionStep(identifier: "scaleStepIntro")
        scaleStepIntro.title = "Other things to think about"
        scaleStepIntro.text = "Every woman's feelings and concerns are different, and it may be helpful to think about what's important to you. The statements and questions below will give you a chance to explore your feelings about screening mammograms and breast cancer. There is no right or wrong answer."
        steps += [scaleStepIntro]
        
        // Step 1
        var step = ORKFormStep.init(identifier: "step1", title: "I'm willing to do anything to detect breast cancer as early as possible.", text: nil)
        var stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        var item = ORKFormItem.init(identifier: "item1", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]
        
        // Step 2
        step = ORKFormStep.init(identifier: "step2", title: "Screening mammograms are painful and inconvenient.", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item2", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 3
        step = ORKFormStep.init(identifier: "step3", title: "I only want to have mammograms if I am at high risk for breast cancer.", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item3", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 4
        step = ORKFormStep.init(identifier: "step4", title: "I want my doctor to tell me when to have mammograms.", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item4", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 5
        step = ORKFormStep.init(identifier: "step5", title: "I have enough information to make a decision about screening mammograms.", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item5", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 6
        step = ORKFormStep.init(identifier: "step6", title: "Making a decision about when to start and how often to have mammograms is stressful.", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item6", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 7
        step = ORKFormStep.init(identifier: "step7", title: "How worried are you about getting breast cancer?", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item7", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        // Step 8
        step = ORKFormStep.init(identifier: "step8", title: "How concerned are you about the possible harms of screening mammograms?", text: nil)
        stepAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: 0, step: 1, vertical: false, maximumValueDescription: "Strongly\nDisagree", minimumValueDescription: "Strongly\nAgree")
        item = ORKFormItem.init(identifier: "item8", text: "", answerFormat: stepAnswerFormat)
        step.formItems = [item]
        step.isOptional = false
        steps += [step]

        return ORKOrderedTask(identifier: "valuesSurveyTask", steps: steps)
    }()
    
}
