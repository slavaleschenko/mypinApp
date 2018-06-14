//
//  PinsAndBoardsServicesExtension.swift
//  MyPins&Boards
//
//  Created by Admin on 03.06.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation

extension Services {
    func getBoardName(completion: @escaping ([BoardName]) -> ()) {
        
        guard let token = UserDefaults.standard.string(forKey: "token") else{
            print("token equals nil")
            return
        }
        guard let url = URL(string: "https://api.pinterest.com/v1/me/boards/?access_token=\(token)&fields=name") else {
            print("URL is equal to nil")
            return
        }
        dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateBoardList(data)
                DispatchQueue.main.async {
                    completion(self.boardList)
                }
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateBoardList(_ data: Data) {
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
        for board in array {
            if let board = board as? JSONDictionary,
                let id = board["id"] as? String,
                let name = board["name"] as? String {
                boardList.append(BoardName(name: name, id: id))
            } else {
                print("Problem parsing params")
            }
        }
    }
    
}
