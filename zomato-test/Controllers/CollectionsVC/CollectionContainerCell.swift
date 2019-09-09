//
//  CollectionContainerCell.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class CollectionContainerCell:UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allCollectionsButton: UIButton!
    var collections:Array<Collection>!
    var parent:CollectionsVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell:CollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        let collection = collections[indexPath.row]
        collectionCell.title.text = collection.title
        collectionCell.collectionDescription.text = collection.description
        collectionCell.resCounts.text = "\(collection.resCount) places"
        collectionCell.layer.cornerRadius = 10
        let url = URL(string: collection.imageUrl)
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseImage{ response in
            if (response.result.value != nil){
                collectionCell.image.image = response.result.value
                collectionCell.image.contentMode = .scaleToFill
            }
        }
        return collectionCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collections.count < 6{
            return collections.count
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parent.selectedCollection = collections[indexPath.row]
        parent.performSegue(withIdentifier: "restaurants", sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
