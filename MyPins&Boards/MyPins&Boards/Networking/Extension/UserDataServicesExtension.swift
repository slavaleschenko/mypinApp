//
//  UserDataServicesExtension.swift
//  MyPins&Boards
//
//  Created by Admin on 03.06.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation

extension Services {
    func getUsersData(completion: @escaping ([UserData]) -> ()) {
        
        let token = UserDefaults.standard.string(forKey: "token")
        guard let url = URL(string: "https://api.pinterest.com/v1/me/?access_token=\(token!)&fields=username,first_name,last_name") else {
            print("url is equal to nil")
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateUserData(data)
                DispatchQueue.main.async {
                    completion(self.userData)
                }
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateUserData(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        
        guard let array = response!["data"]! as? JSONDictionary else {
            print("Dictionary does not contain data key\n")
            return
        }
        
        if  let username = array["username"] as? String,
            let firstName = array["first_name"] as? String,
            let lastName = array["last_name"] as? String {
            userData.append(UserData(username: username, firstName: firstName, lastName: lastName))
            UserDefaults.standard.set("\(username)", forKey: "username")
        } else {
            print("Problem parsing params\n")
        }
    }
}
