//
//  PinsImages.swift
//  MyPins&Boards
//
//  Created by Admin on 22.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class PinsImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    typealias JSONDictionary = [String: Any]
    
    var boardName: String?
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pinList = [PinsModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getPins { (pinList) in
//            self.pinList = pinList
//            self.collectionView.reloadData()
//        }
//        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getPins { (pinList) in
            self.pinList = pinList
            self.collectionView.reloadData()
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PinsImagesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myPin", for: indexPath) as! PinsImagesCollectionViewCell
        DispatchQueue.global().async {
            let imageString = self.pinList[indexPath.row].url
            let imageUrl = URL(string: imageString!)
            let imageData = NSData(contentsOf: imageUrl!)
            DispatchQueue.main.async {
                cell.imageViewCollect.image = UIImage(data: imageData! as Data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    // MARK: REQUEST
    
    func getPins(completion: @escaping ([PinsModel]) -> ()) {
        let board = boardName?.replacingOccurrences(of: " ", with: "_")
        print(board!)
        let username = UserDefaults.standard.string(forKey: "username")!
//        print(board)
//        print(username)
        let token = UserDefaults.standard.string(forKey: "token")!
        let url = URL(string: "https://api.pinterest.com/v1/boards/\(username)/\(board!)/pins/?access_token=\(token)&fields=image")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updatePinsList(data)
                
                DispatchQueue.main.async {
                    completion(self.pinList)
                }
            }
            }
            .resume()
    }
    
    func updatePinsList(_ data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                        print(response!)
                        print(response!["data"]!)
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return
        }
        
        guard let array = response!["data"]! as? NSArray else {
            print("Dictionary does not contain data key\n")
            return
        }
        for pin in array {
            if let pin = pin as? JSONDictionary,
            let image = pin["image"] as? JSONDictionary {
                let imageParams = image["original"] as? JSONDictionary
                let imageUrl = imageParams!["url"] as? String
                
                pinList.append(PinsModel(url: imageUrl))
                print(pinList[0].url!)
            } else {
                print("YOUSUCK!")
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
