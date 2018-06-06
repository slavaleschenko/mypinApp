//
//  ProfileViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   
    var services = Services()
    
    var userData = [UserData]()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var showPinsBoardsButton: UIButton!
    
    @IBAction func didTapShowPinsBoardsButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        
        services.getUsersData { (userData) in
            self.userData = userData
            self.userName.text = self.userData[0].username
            self.firstName.text = self.userData[0].firstName
            self.lastName.text = self.userData[0].lastName
            
            self.userName.center.x = self.view.center.x
            self.firstName.center.x = self.view.center.x
            self.lastName.center.x = self.view.center.x
        }
        super.viewDidLoad()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        services.getToken()
//    }
}
