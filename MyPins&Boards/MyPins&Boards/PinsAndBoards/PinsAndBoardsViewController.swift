//
//  PinsAndBoardsViewController.swift
//  MyPins&Boards
//
//  Created by Admin on 11.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class PinsAndBoardsViewController: UITableViewController {

    typealias JSONDictionary = [String: Any]
    
    var boardList = [BoardName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBoardName { (boardList) in
            self.boardList = boardList
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return boardList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func getBoardName(completion: @escaping ([BoardName]) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")!
        let url = URL(string: "https://api.pinterest.com/v1/me/boards/?access_token=\(token)&fields=name")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateBoardList(data)
                
                DispatchQueue.main.async {
                    completion(self.boardList)
                }
            }
            }
            .resume()
        
    }
    
    func updateBoardList(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
//            let response = try [JSONDecoder().decode(ListOfBoards.self, from: data)]
//            print(response!)
//            print(response!["data"]!)
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        
        guard let array = response!["data"]! as? NSArray else {
            print("Dictionary does not contain data key\n")
            return
        }

        for board in array {
            if let board = board as? JSONDictionary,
            let id = board["id"] as? String,
                let name = board["name"] as? String {
                boardList.append(BoardName(name: name, id: id))
//                print(boardList)
            } else {
                print("YOUSUCK!")
            }
        }
        
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        let  segue.identifier = "showPinsSeque",
//        _ = segue.destination as? PinsImagesViewController
        if  segue.identifier == "showPinsSeque",
            let destination = segue.destination as? PinsImagesViewController,
            let index = tableView.indexPathForSelectedRow?.section
        {
            destination.boardName = boardList[index].name
        }
        
    }
    

}
