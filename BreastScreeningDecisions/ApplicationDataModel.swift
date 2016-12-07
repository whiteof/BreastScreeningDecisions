//
//  ApplicationDataModel.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/17/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import Foundation
import ResearchKit

class ApplicationDataModel {
    
    static let sharedInstance = ApplicationDataModel()
    
    let userDefaults = UserDefaults.standard
    
    private var yourRiskSurveyTaskResult: ORKTaskResult!
    private var yourRiskSurveyResponse: [String:Float]!
    private var valuesSurveyTaskResult: ORKTaskResult!
    
    private func convertJsonResponseToDictionary(text: String) -> [String: Float]? {
        var dict: [String:String]!
        var returnDict = [String:Float]()
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if let data = trimmedText.data(using: .utf8) {
            do {
                dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                for (index, element) in dict {
                    returnDict[index] = Float(element)
                }
                return returnDict
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func initialize() {
        var userDefaultsData = Data()
        var taskResult = ORKTaskResult()
        // set Your Risk Survey data
        var userDefaultsValue = self.userDefaults.object(forKey: "YourRiskTaskResult")
        if(userDefaultsValue != nil) {
            userDefaultsData = userDefaultsValue as! Data
            taskResult = NSKeyedUnarchiver.unarchiveObject(with: userDefaultsData) as! ORKTaskResult
            self.yourRiskSurveyTaskResult = taskResult
        }
        // set Values Survey data
        userDefaultsValue = self.userDefaults.object(forKey: "ValuesTaskResult")
        if(userDefaultsValue != nil) {
            userDefaultsData = userDefaultsValue as! Data
            taskResult = NSKeyedUnarchiver.unarchiveObject(with: userDefaultsData) as! ORKTaskResult
            self.valuesSurveyTaskResult = taskResult
        }
        // set Your Risk Response
        userDefaultsValue = self.userDefaults.object(forKey: "YourRiskSurveyResponse")
        if(userDefaultsValue != nil) {
            let jsonStr = userDefaultsValue as! String
            self.yourRiskSurveyResponse = self.convertJsonResponseToDictionary(text: jsonStr)
        }
    }
    
    func setYourRiskSurveyTaskResult(data: ORKTaskResult) {
        // set task result
        self.yourRiskSurveyTaskResult = data
        // save to UserDefaults
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        self.userDefaults.set(encodedData, forKey: "YourRiskTaskResult")
        self.userDefaults.synchronize()        
    }
    
    func getYourRiskTaskResult() -> ORKTaskResult {
        return self.yourRiskSurveyTaskResult
    }
    
    func getYourRiskSurveyCompleted() -> Bool {
        var returnValue = false
        if(self.yourRiskSurveyTaskResult != nil) {
            returnValue = true
        }
        return returnValue
    }
    
    func getYourRiskSurveyJson() -> String {
        var jsonStr = ""
        let taskResult = self.getYourRiskTaskResult()
        let objResearchKitHelper = ResearchKitHelper()
        
        var jsonDict = [String:Any]()
        var answer: Any!
        // Question 1: How Old Are You?
        answer = objResearchKitHelper.getFormattedNumericAnswer(taskResult: taskResult, stepIdentifier: "question1")
        if(answer != nil) {
            jsonDict["age"] = answer
        }else {
            jsonDict["age"] = ""
        }
        // Question 2: What is your race/ethnicity?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question2")
        if(answer != nil) {
            let race = answer as! String
            jsonDict["race"] = race
            if(race == "ASIAN OR PACIFIC ISLANDER") {
                // Question 2.1: What is your race/ethnicity?
                answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question2_1")
                jsonDict["raceAPI"] = answer
                jsonDict["raceProcessed"] = answer
            }else {
                jsonDict["raceAPI"] = ""
                jsonDict["raceProcessed"] = race
            }
        }else {
            jsonDict["race"] = ""
            jsonDict["raceAPI"] = ""
            jsonDict["raceProcessed"] = ""
        }
        // Question 3: How old were you at your first menstrual period?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question3")
        if(answer != nil) {
            jsonDict["ageFirstMenstrualPeriod"] = answer
        }else {
            jsonDict["ageFirstMenstrualPeriod"] = ""
        }
        // Question 4: Have you had any children?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question4")
        if(answer != nil) {
            let anyChildren = answer as! String
            jsonDict["anyChildren"] = anyChildren
            if(anyChildren == "YES") {
                // Question 4_1: How old were you when your 1st child was born?
                answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question4_1")
                jsonDict["ageFirstLiveBirth"] = answer as! String
                jsonDict["ageFirstLiveBirthProcessed"] = answer as! String
            }else {
                jsonDict["ageFirstLiveBirth"] = ""
                jsonDict["ageFirstLiveBirthProcessed"] = "NO BIRTHS"
            }
        }else {
            jsonDict["anyChildren"] = ""
            jsonDict["ageFirstLiveBirth"] = ""
            jsonDict["ageFirstLiveBirthProcessed"] = ""
        }
        // Question 5: Have you ever had a breast biopsy?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question5")
        if(answer != nil) {
            let everHadBreastBiopsy = answer as! String
            jsonDict["everHadBreastBiopsy"] = everHadBreastBiopsy
            if(everHadBreastBiopsy == "YES") {
                // Question 5_1: How many breast biopsies (positive or negative) have you had?
                answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question5_1")
                jsonDict["howManyBreastBiopsy"] = answer as! String
                jsonDict["howManyBreastBiopsyProcessed"] = answer as! String
            }else {
                jsonDict["howManyBreastBiopsy"] = ""
                jsonDict["howManyBreastBiopsyProcessed"] = "NA"
            }
        }else {
            jsonDict["everHadBreastBiopsy"] = ""
            jsonDict["howManyBreastBiopsy"] = ""
            jsonDict["howManyBreastBiopsyProcessed"] = ""
        }
        // Question 6: Have you ever been diagnosed with atypical ductal hyperplasia of the breast?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question6")
        if(answer != nil) {
            jsonDict["everHadHyperplasia"] = answer as! String
        }else {
            jsonDict["everHadHyperplasia"] = ""
        }
        // Question 7: How many of your first-degree relatives (mother, sisters, daughters) have had breast cancer?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question7")
        if(answer != nil) {
            let firstDegreeRelativesBreastCancer = answer as! String
            jsonDict["firstDegreeRelativesBreastCancer"] = firstDegreeRelativesBreastCancer
            if(firstDegreeRelativesBreastCancer == "1" || firstDegreeRelativesBreastCancer == "MORE THAN 1") {
                // Question 7_1: Were any of them under age 50 when they were diagnosed?
                answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question7_1")
                jsonDict["anyfirstDegreeRelativesBreastCancerUnder50"] = answer as! String
            }else {
                jsonDict["anyfirstDegreeRelativesBreastCancerUnder50"] = ""
            }
        }else {
            jsonDict["firstDegreeRelativesBreastCancer"] = ""
            jsonDict["anyfirstDegreeRelativesBreastCancerUnder50"] = ""
        }
        // Question 8: Have any of your first degree relatives (mother, sisters, daughters) had ovarian cancer?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question8")
        if(answer != nil) {
            jsonDict["firstDegreeRelativesOvarian"] = answer as! String
        }else {
            jsonDict["firstDegreeRelativesOvarian"] = ""
        }
        // Question 9: Have you ever been diagnosed with breast cancer?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question9")
        if(answer != nil) {
            jsonDict["everDiagnosedBreastCancer"] = answer as! String
        }else {
            jsonDict["everDiagnosedBreastCancer"] = ""
        }
        // Question 10: Have you ever been diagnosed with ductal carcinoma in situ (DCIS) or lobular carcinoma in situ (LCIS)?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question10")
        if(answer != nil) {
            jsonDict["everDiagnosedDCISLCIS"] = answer as! String
        }else {
            jsonDict["everDiagnosedDCISLCIS"] = ""
        }
        // Question 11: Have you ever been told that you carry a genetic mutation for the BRCA1 or BRCA2 gene?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question11")
        if(answer != nil) {
            jsonDict["everDiagnosedBRCA1BRCA2"] = answer as! String
        }else {
            jsonDict["everDiagnosedBRCA1BRCA2"] = ""
        }
        // Question 12: Have you ever had radiation therapy to the chest for another medical condition?
        answer = objResearchKitHelper.getFormattedTextChoiceAnswer(taskResult: taskResult, stepIdentifier: "question12")
        if(answer != nil) {
            jsonDict["everHadRadiationTherapy"] = answer as! String
        }else {
            jsonDict["everHadRadiationTherapy"] = ""
        }
        /*
        let bodyDict = [
            "age":40,
            "ageFirstMenstrualPeriod":"7-11",
            "ageFirstLiveBirth":"<20",
            "anyChildren":"YES",
            "anyfirstDegreeRelativesBreastCancerUnder50":"",
            "everDiagnosedBRCA1BRCA2":"NO",
            "everDiagnosedBreastCancer":"NO",
            "everDiagnosedDCISLCIS":"NO",
            "everHadBreastBiopsy":"NO",
            "everHadHyperplasia":"NO",
            "everHadRadiationTherapy":"NO",
            "firstDegreeRelativesBreastCancer":"0",
            "firstDegreeRelativesOvarian":"NO",
            "howManyBreastBiopsy":"",
            "race":"WHITE",
            "raceAPI":"",
            "raceProcessed":"WHITE",
            "ageFirstLiveBirthProcessed":"<20",
            "howManyBreastBiopsyProcessed":"NA"
            ] as [String : Any]
        // convert dict to json str
 */
        var jsonData: Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("Faild json serialization.")
        }
        jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as! String
        
        return jsonStr
    }
    
    func setYourRiskSurveyResponse(data: String) {
        // set task result
        self.yourRiskSurveyResponse = self.convertJsonResponseToDictionary(text: data)
        // save to UserDefaults
        self.userDefaults.set(data, forKey: "YourRiskSurveyResponse")
        self.userDefaults.synchronize()
    }
    
    func resetYourRiskSurveyResponse() {
        // rest task result
        self.yourRiskSurveyResponse = nil
        // reset to UserDefaults
        self.userDefaults.removeObject(forKey: "YourRiskSurveyResponse")
        self.userDefaults.synchronize()
    }
    
    func getYourRiskSurveyResponse() -> [String:Float] {
        return self.yourRiskSurveyResponse
    }

    func isYourRiskSurveyResponseReceived() -> Bool {
        var returnValue = false
        if(self.yourRiskSurveyResponse != nil) {
            returnValue = true
        }
        return returnValue
    }

    func setValuesSurveyTaskResult(data: ORKTaskResult) {
        // set task result
        self.valuesSurveyTaskResult = data
        // save to UserDefaults
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        self.userDefaults.set(encodedData, forKey: "ValuesTaskResult")
        self.userDefaults.synchronize()
        // sync with server
        //SyncHelper.sharedInstance.submitUserData()
    }
    
    func getValuesSurveyCompleted() -> Bool {
        var returnValue = false
        if(self.valuesSurveyTaskResult != nil) {
            returnValue = true
        }
        return returnValue
    }
    
    func getValuesTaskResult() -> ORKTaskResult {
        return self.valuesSurveyTaskResult
    }
    
    func getValuesSurveyData() -> [Float] {
        var returnData:[Float] = []
        
        if(self.getValuesSurveyCompleted()) {
            let taskResult = self.getValuesTaskResult()
            let objResearchKitHelper = ResearchKitHelper()
            var answer: Int!
            // step 1
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step1")
            returnData.append(Float(answer)/10.0)
            // step 2
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step2")
            returnData.append(Float(answer)/10.0)
            // step 3
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step3")
            returnData.append(Float(answer)/10.0)
            // step 4
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step4")
            returnData.append(Float(answer)/10.0)
            // step 5
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step5")
            returnData.append(Float(answer)/10.0)
            // step 6
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step6")
            returnData.append(Float(answer)/10.0)
            // step 7
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step7")
            returnData.append(Float(answer)/10.0)
            // step 8
            answer = objResearchKitHelper.getFormattedScaleAnswer(taskResult: taskResult, stepIdentifier: "step8")
            returnData.append(Float(answer)/10.0)
        }
        return returnData
    }
    
    func removeUserData() {
        // reset values
        self.yourRiskSurveyTaskResult = nil
        self.yourRiskSurveyResponse = nil
        self.valuesSurveyTaskResult = nil
        // remove passcode
        ORKPasscodeViewController.removePasscodeFromKeychain()
        // remove from user defaults
        self.userDefaults.removeObject(forKey: "YourRiskTaskResult")
        self.userDefaults.removeObject(forKey: "YourRiskSurveyResponse")
        self.userDefaults.removeObject(forKey: "ValuesTaskResult")
        self.userDefaults.synchronize()
        // remove tasks to run
        //SyncHelper.sharedInstance.removeTasksToRun()
    }
    
}
