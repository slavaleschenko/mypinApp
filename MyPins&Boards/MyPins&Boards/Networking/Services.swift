//
//  Services.swift
//  MyPins&Boards
//
//  Created by Admin on 02.06.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import Foundation
import UIKit

class Services {
    
    typealias JSONDictionary = [String: Any]
        
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var userData = [UserData]()
    var boardList = [BoardName]()
    var pinList = [PinsModel]()
    
//    var code: String = ""
    var token: String = ""
}
