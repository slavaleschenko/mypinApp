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
    let firstName: String?
    let lastName: String?
    
    init(username: String?, firstName: String?, lastName: String?) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }
}

