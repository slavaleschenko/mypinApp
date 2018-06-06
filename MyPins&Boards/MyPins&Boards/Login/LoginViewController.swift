//
//  ViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 09.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let services = Services()
    
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        services.userAuth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.moveToProfileViewController(notification:)), name: .didFinishAuthorization, object: nil)
        }
    }
    
    @objc func moveToProfileViewController(notification: NSNotification) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

}

