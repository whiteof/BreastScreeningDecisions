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
    private var valuesSurveyTaskResult: ORKTaskResult!
    private var riskPercent: Int = 0
    
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
        // set Risk Percent
        userDefaultsValue = self.userDefaults.object(forKey: "RiskPercent")
        if(userDefaultsValue != nil) {
            self.riskPercent = userDefaultsValue as! Int
        }
    }
    
    func setYourRiskSurveyTaskResult(data: ORKTaskResult) {
        // set task result
        self.yourRiskSurveyTaskResult = data
        // save to UserDefaults
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
        self.userDefaults.set(encodedData, forKey: "YourRiskTaskResult")
        self.userDefaults.synchronize()
        // sync with server
        //SyncHelper.sharedInstance.submitUserData()
    }
    
    func getYourRiskSurveyCompleted() -> Bool {
        var returnValue = false
        if(self.yourRiskSurveyTaskResult != nil) {
            returnValue = true
        }
        return returnValue
    }
    
    func getYourRiskTaskResult() -> ORKTaskResult {
        return self.yourRiskSurveyTaskResult
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
    
    func getRiskPercent() -> Int {
        return self.riskPercent
    }
    
    func setRiskPercent(data: Int) {
        // set task result
        self.riskPercent = data
        // save to UserDefaults
        self.userDefaults.set(data, forKey: "RiskPercent")
        self.userDefaults.synchronize()
    }
    
    func removeUserData() {
        // reset values
        self.yourRiskSurveyTaskResult = nil
        self.valuesSurveyTaskResult = nil
        self.riskPercent = 0
        // remove passcode
        ORKPasscodeViewController.removePasscodeFromKeychain()
        // remove from user defaults
        self.userDefaults.removeObject(forKey: "YourRiskTaskResult")
        self.userDefaults.removeObject(forKey: "ValuesTaskResult")
        self.userDefaults.removeObject(forKey: "RiskPercent")
        self.userDefaults.synchronize()
        // remove tasks to run
        //SyncHelper.sharedInstance.removeTasksToRun()
    }
    
}
