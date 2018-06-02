//
//  ProfileUserDataModel.swift
//  MyPins&Boards
//
//  Created by Admin on 13.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class UserData {
    
    let username: String?
    let first_name: String?
    let last_name: String?
    
    init(username: String?, first_name: String?, last_name: String?) {
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
    }
}

//class Data: Codable {
//    let data: [UserData]
//    
//    init(data: [UserData]) {
//        self.data = data
//    }
//}
