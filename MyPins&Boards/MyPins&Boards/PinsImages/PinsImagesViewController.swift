//
//  PinsImages.swift
//  MyPins&Boards
//
//  Created by Admin on 22.05.18.
//  Copyright © 2018 SlavaLes. All rights reserved.
//

import UIKit

class PinsImagesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let service = Services()
    let vc = ProfileViewController()
    
    var boardName: String?
    var pinList = [PinsModel]()
   
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        service.getPins(board: boardName) { (pinList) in
            self.pinList = pinList
            self.collectionView.reloadData()
        }
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
}
