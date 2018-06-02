//
//  ProfileViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    typealias JSONDictionary = [String: Any]
    
    
    var userData = [UserData]()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var showPinsBoardsButton: UIButton!
    
    @IBAction func didTapShowPinsBoardsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        getUsersData { (userData) in
            self.userData = userData
            self.userName.text = self.userData[0].username
            self.firstName.text = self.userData[0].first_name
            self.lastName.text = self.userData[0].last_name
            
            self.userName.center.x = self.view.center.x
            self.firstName.center.x = self.view.center.x
            self.lastName.center.x = self.view.center.x
        }
        
        super.viewDidLoad()
    }
    
    func getUsersData(completion: @escaping ([UserData]) -> ()) {
        
        let token = UserDefaults.standard.string(forKey: "token")!
        let url = URL(string: "https://api.pinterest.com/v1/me/?access_token=\(token)&fields=username,first_name,last_name")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
        .resume()
    }
    
    func updateUserData(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
            
//            print(response!)
//            print(response!["data"]!)
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
            userData.append(UserData(username: username, first_name: firstName, last_name: lastName))
            print(userData[0].first_name!)
            UserDefaults.standard.set("\(username)", forKey: "username")
//            updateLabels()
            } else {
                print("Problem parsing params\n")
            }
        
    }
    
//    func updateLabels() {
//        DispatchQueue.main.async {
//            self.userName.text = self.userData[0].username
//            self.firstName.text = self.userData[0].first_name
//            self.lastName.text = self.userData[0].last_name
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
