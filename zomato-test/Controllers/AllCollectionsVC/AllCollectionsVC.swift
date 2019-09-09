//
//  AllCollectionsVC.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AllCollectionsVC:UIViewController{
    
    var collections:Array<Collection>!
    var selectedCollection:Collection!
    var selectedLocaiton:Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Collections"
    }
    
}

extension AllCollectionsVC:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionCell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! AllCollectionsCell
        let collection = collections[indexPath.row]
        collectionCell.title.text = collection.title
        collectionCell.cDescription.text = collection.description
        collectionCell.resCount.text = "\(collection.resCount) PLACES"
        let url = URL(string: collection.imageUrl)
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseImage{ response in
            if (response.result.value != nil){
                collectionCell.banner.image = response.result.value
                collectionCell.banner.contentMode = .scaleToFill
            }
        }
        collectionCell.container.layer.cornerRadius = 10
        collectionCell.container.clipsToBounds = true
        collectionCell.contentView.backgroundColor = .clear
        return collectionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollection = collections[indexPath.row]
        self.performSegue(withIdentifier: "restaurants", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let restaurantsVC = segue.destination as! RestaurantsVC
        restaurantsVC.collection = selectedCollection
        restaurantsVC.location = selectedLocaiton
    }
}

