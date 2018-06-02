//
//  ViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 09.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        let baseUrl = "https://api.pinterest.com/oauth/"
        let clientId = "4964913558019127315"
        let state = "768uyFys"
        let redirectUri = "pdk4964913558019127315://"
        
        let requestUrl = URL(string: "\(baseUrl)?response_type=code&client_id=\(clientId)&state=\(state)&scope=read_public&redirect_uri=\(redirectUri)")!
        
        UIApplication.shared.open(requestUrl, options: [:], completionHandler: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.moveToProfileViewController(notification:)), name: .didFinishAuthorization, object: nil)
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(moveToProfileViewController(notification:)), name: .didFinishAuthorization, object: nil)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func moveToProfileViewController(notification: NSNotification) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

}

