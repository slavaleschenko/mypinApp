//
//  PinsAndBoardsViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class PinsAndBoardsViewController: UITableViewController {

    var services = Services()
    
    var boardList = [BoardName]()
    
    override func viewDidLoad() {
        services.getBoardName { (boardList) in
            self.boardList = boardList
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return boardList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "boardNameCell", for: indexPath) as? BoardsCell
            else {return UITableViewCell()}
        cell.boardName.text = boardList[indexPath.section].name
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if  segue.identifier == "showPinsSeque",
            let destination = segue.destination as? PinsImagesViewController,
            let index = tableView.indexPathForSelectedRow?.section
        {
            print(index)
            destination.boardName = boardList[index].name
        }
    }
    

}
