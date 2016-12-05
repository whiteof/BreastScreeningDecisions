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
        // step 1
        answer = objResearchKitHelper.getFormattedNumericAnswer(taskResult: taskResult, stepIdentifier: "step1")
        if(answer != nil) {
            jsonDict["age"] = answer
        }else {
            jsonDict["age"] = ""
        }
        
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
        var jsonData: Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("Faild json serialization.")
        }
        jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as! String
        print(jsonStr)
        
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
