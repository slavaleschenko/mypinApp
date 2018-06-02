//
//  PinsAndBoardsModel.swift
//  MyPins&Boards
//
//  Created by Admin on 17.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class BoardName {
    let id: String?
    let name: String?

    init(name: String?, id: String?) {
        self.id = id
        self.name = name
    }
}

//class ListOfBoards: Codable {
//    let boardList: [BoardName]
//
//    init(boardList: [BoardName]) {
//        self.boardList = boardList
//    }
//}
