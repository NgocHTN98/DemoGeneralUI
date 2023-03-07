//
//  Service.swift
//  DemoGeneralUI
//
//  Created by NgocHTN6 on 07/03/2023.
//

import Foundation
class Service {
    
    func request() {
        var request = URLRequest(url: URL(string: "https://mock.apidog.com/m1/359057-0-default/m2/359057-0-default/3648051")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("JSON Serialization error")
            }
        })

        task.resume()
    }
}
struct Response {
    let message: String
    let statusCode: Int
}
