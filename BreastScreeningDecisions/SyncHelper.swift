//
//  SyncHelper.swift
//  BreastScreeningDecisions
//
//  Created by Victor Yurkin on 11/30/16.
//  Copyright © 2016 Weill Cornell Medicine. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

class Response {
    var responseCode: Int!
    var responseString: String!
}

class SyncHelper {
    
    static let sharedInstance = SyncHelper()
    
    private let client_id = "demoappuserios"
    private let client_secret = "jjdgheWSfd45"
    private var access_token = ""
    
    private let userDefaults = UserDefaults.standard
    private let syncGroup = DispatchGroup()
    private var tasksToRun = [String]()
    private var isSyncProcessRunning = false
    
    // Private functions
    
    // sync process functions
    
    private func runSyncTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runSyncProcess), userInfo: nil, repeats: false)
    }
    
    @objc private func runSyncProcess() {
        // mark as running
        self.isSyncProcessRunning = true
        DispatchQueue.global(qos: .background).async {
            /***** SYNC USER DATA *****/
            if(self.tasksToRun.contains("SendUserData")) {
                let queueUserData = DispatchQueue(label: "queueUserData")
                queueUserData.async(group: self.syncGroup) {
                    // SendUserDataTask
                    let urlStr = "http://140.251.10.20/get-risk/index.cfm"
                    let bodyDict = [
                        "age":"40",
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
                        ] as [String : String]
                    // convert dict to json str
                    var jsonData: Data = Data()
                    do {
                        jsonData = try JSONSerialization.data(withJSONObject: bodyDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                    } catch {
                        print("Faild json serialization.")
                    }
                    let bodyStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                    // send request
                    self.sendAsyncPostRequest(url: urlStr, body: bodyStr as! String, completion: {(result) -> Void in
                        if(result.responseCode == 200) {
                            // remove from task queue
                            let index = self.tasksToRun.index(of: "SendUserData")!
                            if(index >= 0) {
                                self.tasksToRun.remove(at: index)
                                self.saveTasksToRun()
                            }
                        }else {
                            if(result.responseCode == 401) {
                                self.refreshAccessToken()
                            }else {
                                print(result.responseString)
                            }
                        }
                    })
                }
            }
            /***** SYNC USER DATA *****/
            /*
            if(self.tasksToRun.contains("SendEmail")) {
                // check access tocken
                if(self.access_token == "") {
                    self.setAccessToken()
                }
                if(self.access_token == ""){
                    DispatchQueue.main.async {
                        self.runSyncTimer()
                    }
                }else {
                    let queueUserData = DispatchQueue(label: "queueUserData")
                    queueUserData.async(group: self.syncGroup) {
                        // SendUserDataTask
                        let urlStr = "http://api.researchtoolsapp.com/api/appios/submit?access_token=\(self.access_token)"
                        
                        var answers = [[String:Any]]()
                        var answer: Any!
                        // first name
                        answer = ApplicationDataModel.sharedInstance.getFirstName()
                        if(answer != nil) {
                            answers.append([
                                "question": "research_apps_demo_onboarding_first_name",
                                "answer": answer!
                                ])
                        }else {
                            answers.append([
                                "question": "research_apps_demo_onboarding_first_name"
                                ])
                        }
                        
                        let bodyDict = [
                            "device_id": UIDevice.current.identifierForVendor!.uuidString,
                            "answers": answers
                            ] as [String : Any]
                        // convert dict to json str
                        var jsonData: Data = Data()
                        do {
                            jsonData = try JSONSerialization.data(withJSONObject: bodyDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                        } catch {
                            print("Faild json serialization.")
                        }
                        let bodyStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                        // send request
                        self.sendAsyncPostRequest(url: urlStr, body: bodyStr as! String, completion: {(result) -> Void in
                            if(result.responseCode == 201) {
                                // remove from task queue
                                let index = self.tasksToRun.index(of: "SendUserDataTask")!
                                if(index >= 0) {
                                    self.tasksToRun.remove(at: index)
                                    self.saveTasksToRun()
                                }
                            }else {
                                if(result.responseCode == 401) {
                                    self.refreshAccessToken()
                                }else {
                                    print(result)
                                }
                            }
                        })
                    }
                }
            }
 */
            self.syncGroup.notify(queue: DispatchQueue.main) {
                // all tasks done. if taks left in queue run sync process again in 10 seconds
                if(self.tasksToRun.count > 0) {
                    DispatchQueue.main.async {
                        self.runSyncTimer()
                    }
                }else {
                    self.isSyncProcessRunning = false
                }
            }
        }
    }
    
    private func sendSyncPostRequest(url: String, body: String, completion: @escaping (_ result: Response) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = body
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultObject = Response()
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                semaphore.signal()
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                resultObject.responseCode = httpStatus.statusCode
                resultObject.responseString = responseString
            }else {
                resultObject.responseCode = 200
                resultObject.responseString = responseString
            }
            completion(resultObject)
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    private func sendAsyncPostRequest(url: String, body: String, completion: @escaping (_ result: Response) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postString = body
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultObject = Response()
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                resultObject.responseCode = httpStatus.statusCode
                resultObject.responseString = responseString
            }else {
                resultObject.responseCode = 200
                resultObject.responseString = responseString
            }
            completion(resultObject)
        }
        task.resume()
    }
    
    private func sendAsyncDeleteRequest(url: String, body: String, completion: @escaping (_ result: Response) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postString = body
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultObject = Response()
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                resultObject.responseCode = httpStatus.statusCode
                resultObject.responseString = responseString
            }else {
                resultObject.responseCode = 200
                resultObject.responseString = responseString
            }
            completion(resultObject)
        }
        task.resume()
    }
    
    private func setAccessToken() {
        let urlStr = "http://api.researchtoolsapp.com/oauth"
        let bodyStr = "grant_type=client_credentials&client_id=\(self.client_id)&client_secret=\(self.client_secret)"
        self.sendSyncPostRequest(url: urlStr, body: bodyStr, completion: {(result) -> Void in
            if(result.responseCode == 200) {
                let nsData: NSData = result.responseString.data(using: .utf8)! as NSData
                do {
                    let json = try JSONSerialization.jsonObject(with: nsData as Data, options: .allowFragments) as! [String:AnyObject]
                    self.access_token = json["access_token"] as! String
                } catch {
                    print(error)
                }
            }else {
                print(result)
            }
        })
    }
    
    private func refreshAccessToken() {
        let urlStr = "http://api.researchtoolsapp.com/oauth"
        let bodyStr = "grant_type=refresh_token&refresh_token=\(self.access_token)&client_id=\(self.client_id)&client_secret=\(self.client_secret)"
        self.sendSyncPostRequest(url: urlStr, body: bodyStr, completion: {(result) -> Void in
            if(result.responseCode == 200) {
                let nsData: NSData = result.responseString.data(using: .utf8)! as NSData
                do {
                    let json = try JSONSerialization.jsonObject(with: nsData as Data, options: .allowFragments) as! [String:AnyObject]
                    self.access_token = json["access_token"] as! String
                } catch {
                    print(error)
                }
            }else {
                print(result)
            }
        })
    }
    
    private func saveTasksToRun() {
        self.userDefaults.set(self.tasksToRun, forKey: "TasksToRun")
        self.userDefaults.synchronize()
    }
    
    private func loadTasksToRun() {
        let userDefaultsValue = self.userDefaults.object(forKey: "TasksToRun")
        if(userDefaultsValue != nil) {
            self.tasksToRun = userDefaultsValue as! [String]
        }
    }
    
    func removeTasksToRun() {
        self.userDefaults.removeObject(forKey: "TasksToRun")
        self.userDefaults.synchronize()
        self.tasksToRun = []
    }
    
    // Public functions
    
    func initialize() {
        // load tasks from userDefaults
        self.loadTasksToRun()
        if(self.tasksToRun.count > 0) {
            self.runSyncProcess()
        }
        
    }
    
    func sendSyncPostJsonRequest(url: String, body: String, completion: @escaping (_ result: Response) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postString = body
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let resultObject = Response()
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                semaphore.signal()
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                resultObject.responseCode = httpStatus.statusCode
                resultObject.responseString = responseString
            }else {
                resultObject.responseCode = 200
                resultObject.responseString = responseString
            }
            completion(resultObject)
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    
}
