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
        let service = Services()
        service.getToken(with: String(code))
        return true
    }
}

