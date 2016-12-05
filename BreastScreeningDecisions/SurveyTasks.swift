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
        
        // Question 1: How Old Are You?
        let step1 = ORKFormStep(identifier: "question1", title: NSLocalizedString("How Old Are You?", comment: ""), text: nil)
        step1.isOptional = false
        let format1 = ORKAnswerFormat.decimalAnswerFormat(withUnit: NSLocalizedString("Your age", comment: ""))
        let item1 = ORKFormItem(identifier: "item1", text: "", answerFormat: format1)
        step1.formItems = [item1]
        steps += [step1]
        
        // Question 2: What is your race/ethnicity?
        let textChoices2 = [
            ORKTextChoice(text: "White", value: "WHITE" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "African American", value: "AFRICAN AMERICAN" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hispanic", value: "HISPANIC" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Asian or Pacific Islander", value: "ASIAN OR PACIFIC ISLANDER" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "American Indian or Alaskan Native", value: "AMERICAN INDIAN OR ALASKAN NATIVE" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format2: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
        let step2 = ORKQuestionStep(identifier: "question2", title: "What is your race/ethnicity?", answer: format2)
        step2.isOptional = false
        steps += [step2]
        
        // Question 2.1: What is your race/ethnicity?
        let textChoices2_1 = [
            ORKTextChoice(text: "Chinese", value: "7" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Filipino", value: "9" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Japanese", value: "8" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hawaiian", value: "10" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other Pacific Islander", value: "11" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other Asian-American", value: "12" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format2_1: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2_1)
        let step2_1 = ORKQuestionStep(identifier: "question2_1", title: "Please select one your race/ethnicity:", answer: format2_1)
        step2_1.isOptional = false
        steps += [step2_1]
        
        // Question 3: How old were you at your first menstrual period?
        let textChoices3 = [
            ORKTextChoice(text: "7-11", value: "7-11" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "12-13", value: "12-13" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "14 or Older", value: ">=14" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "DoNotKnow" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format3: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices3)
        let step3 = ORKQuestionStep(identifier: "question3", title: "How old were you at your first menstrual period?", answer: format3)
        step3.isOptional = false
        steps += [step3]
        
        // Question 4: Have you had any children?
        let textChoices4 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format4: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4)
        let step4 = ORKQuestionStep(identifier: "question4", title: "Have you had any children?", answer: format4)
        step4.isOptional = false
        steps += [step4]
        
        // Question 4_1: How old were you when your 1st child was born?
        let textChoices4_1 = [
            ORKTextChoice(text: "Younger than 20", value: "<20" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "20 to 24", value: "20-24" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "25 to 29", value: "25-29" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "30 or Older", value: ">=30" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "DoNotKnow" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format4_1: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4_1)
        let step4_1 = ORKQuestionStep(identifier: "question4_1", title: "How old were you when your 1st child was born?", answer: format4_1)
        step4_1.isOptional = false
        steps += [step4_1]

        // Question 5: Have you ever had a breast biopsy?
        let textChoices5 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format5: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices5)
        let step5 = ORKQuestionStep(identifier: "question5", title: "Have you ever had a breast biopsy?", answer: format5)
        step5.isOptional = false
        steps += [step5]

        // Question 5_1: How many breast biopsies (positive or negative) have you had?
        let textChoices5_1 = [
            ORKTextChoice(text: "1", value: "1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "More Than 1", value: ">1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "DoNotKnow" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format5_1: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices5_1)
        let step5_1 = ORKQuestionStep(identifier: "question5_1", title: "How many breast biopsies (positive or negative) have you had?", answer: format5_1)
        step5_1.isOptional = false
        steps += [step5_1]
        
        // Question 6: Have you ever been diagnosed with atypical ductal hyperplasia of the breast?
        let textChoices6 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format6: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6)
        let step6 = ORKQuestionStep(identifier: "question6", title: "Have you ever been diagnosed with atypical ductal hyperplasia of the breast?", answer: format6)
        step6.isOptional = false
        steps += [step6]
        
        // Question 7: How many of your first-degree relatives (mother, sisters, daughters) have had breast cancer?
        let textChoices7 = [
            ORKTextChoice(text: "0", value: "0" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "1", value: "1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "More Than 1", value: "MORE THAN 1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "DoNotKnow" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format7: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices7)
        let step7 = ORKQuestionStep(identifier: "question7", title: "How many of your first-degree relatives (mother, sisters, daughters) have had breast cancer?", answer: format7)
        step7.isOptional = false
        steps += [step7]

        // Question 7_1: Were any of them under age 50 when they were diagnosed?
        let textChoices7_1 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format7_1: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices7_1)
        let step7_1 = ORKQuestionStep(identifier: "question7_1", title: "Were any of them under age 50 when they were diagnosed?", answer: format7_1)
        step7_1.isOptional = false
        steps += [step7_1]
        
        // Question 8: Have any of your first degree relatives (mother, sisters, daughters) had ovarian cancer?
        let textChoices8 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format8: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices8)
        let step8 = ORKQuestionStep(identifier: "question8", title: "Have any of your first degree relatives (mother, sisters, daughters) had ovarian cancer?", answer: format8)
        step8.isOptional = false
        steps += [step8]
        
        // Question 9: Have you ever been diagnosed with breast cancer?
        let textChoices9 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format9: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices9)
        let step9 = ORKQuestionStep(identifier: "question9", title: "Have you ever been diagnosed with breast cancer?", answer: format9)
        step9.isOptional = false
        steps += [step9]
        
        // Question 10: Have you ever been diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS)?
        let textChoices10 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format10: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices10)
        let step10 = ORKQuestionStep(identifier: "question10", title: "Have you ever been diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS)?", answer: format10)
        step10.isOptional = false
        steps += [step10]

        // Question 11: Have you ever been told that you carry a genetic mutation for the BRCA1 or BRCA2 gene?
        let textChoices11 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format11: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices11)
        let step11 = ORKQuestionStep(identifier: "question11", title: "Have you ever been told that you carry a genetic mutation for the BRCA1 or BRCA2 gene?", answer: format11)
        step11.isOptional = false
        steps += [step11]
        
        // Question 12: Have you ever had radiation therapy to the chest for another medical condition?
        let textChoices12 = [
            ORKTextChoice(text: "Yes", value: "YES" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: "NO" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Don't Know", value: "UNKNOWN" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let format12: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices12)
        let step12 = ORKQuestionStep(identifier: "question12", title: "Have you ever had radiation therapy to the chest for another medical condition?", answer: format12)
        step12.isOptional = false
        steps += [step12]

        let task = ORKNavigableOrderedTask(identifier: "yourRiskSurveyTask", steps: steps)
        
        let predicate2 = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: step2.identifier), expectedAnswerValue: "ASIAN OR PACIFIC ISLANDER" as NSCoding & NSCopying & NSObjectProtocol)
        let rule2 = ORKPredicateStepNavigationRule.init(resultPredicates: [predicate2], destinationStepIdentifiers: [step2_1.identifier], defaultStepIdentifier: step3.identifier, validateArrays: false)
        task.setNavigationRule(rule2, forTriggerStepIdentifier: step2.identifier)

        let predicate4 = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: step4.identifier), expectedAnswerValue: "YES" as NSCoding & NSCopying & NSObjectProtocol)
        let rule4 = ORKPredicateStepNavigationRule.init(resultPredicates: [predicate4], destinationStepIdentifiers: [step4_1.identifier], defaultStepIdentifier: step5.identifier, validateArrays: false)
        task.setNavigationRule(rule4, forTriggerStepIdentifier: step4.identifier)

        let predicate5 = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: step5.identifier), expectedAnswerValue: "YES" as NSCoding & NSCopying & NSObjectProtocol)
        let rule5 = ORKPredicateStepNavigationRule.init(resultPredicates: [predicate5], destinationStepIdentifiers: [step5_1.identifier], defaultStepIdentifier: step6.identifier, validateArrays: false)
        task.setNavigationRule(rule5, forTriggerStepIdentifier: step5.identifier)

        let predicate7_1 = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: step7.identifier), expectedAnswerValue: "1" as NSCoding & NSCopying & NSObjectProtocol)
        let predicate7_2 = ORKResultPredicate.predicateForChoiceQuestionResult(with: ORKResultSelector(resultIdentifier: step7.identifier), expectedAnswerValue: "MORE THAN 1" as NSCoding & NSCopying & NSObjectProtocol)
        let predicate7 = NSCompoundPredicate.init(orPredicateWithSubpredicates: [predicate7_1, predicate7_2])
        let rule7 = ORKPredicateStepNavigationRule(resultPredicates: [predicate7], destinationStepIdentifiers: [step7_1.identifier], defaultStepIdentifier: step8.identifier, validateArrays: false)
        task.setNavigationRule(rule7, forTriggerStepIdentifier: step7.identifier)
        
        return task
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
