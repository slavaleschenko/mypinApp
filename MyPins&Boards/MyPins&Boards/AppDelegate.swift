//
//  AppDelegate.swift
//  MyPins&Boards
//
//  Created by Admin on 09.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let absolute = url.absoluteString
        let code = absolute.suffix(from: absolute.range(of: "code=")!.upperBound)
        Services.init().getToken(with: String(code))
//        UserDefaults.standard.set("\(code)", forKey: "code")
//        Services.init().getToken()
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: .didFinishAuthorization, object: nil)
//        }
        
      
        
//        print(code)
        
// GET TOKEN
//        let code = UserDefaults.standard.string(forKey: "code")
//        let url = URL(string: "https://api.pinterest.com/v1/oauth/token?grant_type=authorization_code&client_id=4964913558019127315&client_secret=90880208cc451e6227e3d29fdf14d8c33b0a57a0e289a53846f1f667e3b7b61f&code=\(code)")!
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let postString = "code=\(code)"
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("error=\(String(describing: error))")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(String(describing: response))")
//            }
//
//            let responseString = String(data: data, encoding: .utf8)
//                print("responseString = \(String(describing: responseString))")
//            do {
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
////                print(json!)
//                let token = json!["access_token"] as! String
//                UserDefaults.standard.set("\(token)", forKey: "token")
////                print(token)
////                DispatchQueue.main.async{
////                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
////                    let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
////                    let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
////                    loginVC.navigationController?.pushViewController(profileVC, animated: true)
////                }
//                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .didFinishAuthorization, object: nil)
//                }
//            }
//
//
//        }
//        task.resume()


        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

