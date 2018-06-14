//
//  PinsImagesServicesExtension.swift
//  MyPins&Boards
//
//  Created by Admin on 03.06.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation

extension Services {
    func getPins(board: String?, completion: @escaping ([PinsModel]) -> ()) {

        guard let username = UserDefaults.standard.string(forKey: "username") else {
            print("username equals nil")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            print("token equals nil")
            return
        }
        
        guard let board = board,
            let url = URL(string: "https://api.pinterest.com/v1/boards/\(username)/\(board)/pins/?access_token=\(token)&fields=image")  else {
            print("url is equal to nil")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updatePinsList(data)
                
                DispatchQueue.main.async {
                    completion(self.pinList)
                }
            }
        }
        dataTask?.resume()
    }

    fileprivate func updatePinsList(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        guard let array = response!["data"]! as? NSArray else {
            print("Dictionary does not contain data key\n")
            return
        }
        for pin in array {
            if let pin = pin as? JSONDictionary,
                let image = pin["image"] as? JSONDictionary {
                let imageParams = image["original"] as? JSONDictionary
                let imageUrl = imageParams!["url"] as? String
                
                pinList.append(PinsModel(url: imageUrl))
            } else {
                print("Problem parsing params")
            }
        }
        
    }
}
