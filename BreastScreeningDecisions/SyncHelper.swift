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
    
    private let userDefaults = UserDefaults.standard
    private var needToSendRequest = false
    
    // Public functions
    
    func initialize() {
        let userDefaultsValue = self.userDefaults.object(forKey: "NeedToSendRequest")
        if(userDefaultsValue != nil) {
            self.needToSendRequest = userDefaultsValue as! Bool
        }
    }
    
    func sendPostJsonRequest(url: String, body: String, completion: @escaping (_ result: Response) -> Void) {
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
    
    func setNeedToSendRequest(data: Bool) {
        self.needToSendRequest = data
        self.userDefaults.set(data, forKey: "NeedToSendRequest")
        self.userDefaults.synchronize()
    }
    
    func getNeedToSendRequest() -> Bool {
        return self.needToSendRequest
    }
    
}
