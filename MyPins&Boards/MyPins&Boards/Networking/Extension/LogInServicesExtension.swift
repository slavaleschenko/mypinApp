//
//  LogInServicesExtension.swift
//  MyPins&Boards
//
//  Created by Admin on 03.06.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation
import UIKit

extension Services {
    
    func userAuth() {
        let baseUrl = "https://api.pinterest.com/oauth/"
        let clientId = "4964913558019127315"
        let state = "768uyFys"
        let redirectUri = "pdk4964913558019127315://"
        
        let requestUrl = URL(string: "\(baseUrl)?response_type=code&client_id=\(clientId)&state=\(state)&scope=read_public&redirect_uri=\(redirectUri)")!
       
        UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
    }
    
    func getToken(with code: String) {

        let url = URL(string: "https://api.pinterest.com/v1/oauth/token?grant_type=authorization_code&client_id=4964913558019127315&client_secret=90880208cc451e6227e3d29fdf14d8c33b0a57a0e289a53846f1f667e3b7b61f&code=\(code))")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "code=\(code))"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let token = json!["access_token"] as! String
                self.token = token
                print(self.token)
//                UserDefaults.standard.set("\(token)", forKey: "token")
    
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didFinishAuthorization, object: nil)
                }
            }
        }
        task.resume()
    }
}
