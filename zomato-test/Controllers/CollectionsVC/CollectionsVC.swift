//
//  CollectionsVC.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class CollectionsVC:UIViewController{
    
    var selectedLocation:Location!
    var selectedCollection:Collection!
    var locationNav:LocationNav!
    let restClient = RESTClient()
    let restClientB = RESTClient()
    var collections:Array<Collection> = Array()
    var restaurants:Array<Restaurant> = Array()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationNav = LocationNav(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        locationNav.lcoationName.text = selectedLocation.name
        locationNav.locationButton.addTarget(self, action:#selector(showLocations), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: locationNav)
        self.navigationItem.leftBarButtonItem = barButtonItem
        getCollections()
    }
    
    func getCollections(){
        restClient.url = Constants.endPoints.collections
        restClient.requestMethod = .get
        restClient.headers = ["user-key":Constants.apiKey]
        restClient.params = ["city_id":selectedLocation.id] as Dictionary<String, AnyObject>
        restClient.makeRequest { (response, error) in
            if error != nil{
                print(error!)
            }else{
                self.setCollections(response: response as! Dictionary<String,AnyObject>)
            }
        }
        self.getRestaurants()
    }
    
    func getRestaurants(){
        restClient.url = Constants.endPoints.search
        restClient.requestMethod = .get
        restClient.headers = ["user-key":Constants.apiKey]
        restClient.params = ["entity_id":selectedLocation.id, "entity_type":"city"] as Dictionary<String, AnyObject>
        restClient.makeRequest { (response, error) in
            if error != nil{
                print(error!)
            }else{
                self.setRestaurants(response: response as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func setCollections(response:Dictionary<String,AnyObject>){
        guard let collectionsArr = response.arrayFor(key: "collections") else { return }
        for item in collectionsArr{
            let collectionDict = item["collection"] as! Dictionary<String, AnyObject>
            print(collectionDict)
            collections.append(Collection(collectionDict))
        }
        tableView.reloadData()
    }
    
    func setRestaurants(response:Dictionary<String,AnyObject>){
        let restaurantArr = response.arrayFor(key: "restaurants")!
        for item in restaurantArr{
            let restaurantDict = item["restaurant"] as! Dictionary<String, AnyObject>
            print(restaurantDict)
            restaurants.append(Restaurant(restaurantDict))
        }
        tableView.reloadData()
    }
    
    @objc func showLocations(){
        navigationController?.popViewController(animated: true)
    }
}

extension CollectionsVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let colectionContainer:CollectionContainerCell = tableView.dequeueReusableCell(withIdentifier: "collectionsContainerCell", for: indexPath) as! CollectionContainerCell
            colectionContainer.collections = self.collections
            colectionContainer.collectionView.reloadData()
            colectionContainer.allCollectionsButton.addTarget(self, action: #selector(showAllCollections), for: .touchUpInside)
            colectionContainer.selectionStyle = .none
            colectionContainer.parent = self
            return colectionContainer
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantsCell", for: indexPath) as! RestaurantCell
        let restaurant = restaurants[indexPath.row]
        cell.name.text = restaurant.name
        cell.establishment.text = restaurant.establishment + " - " + restaurant.cuisines
        cell.cost.text = "$\(restaurant.averageCostForTwo) for two people (approx.)"
        cell.location.text = restaurant.location.address
        cell.rating.text = restaurant.userRating.aggregateRating
        cell.rating.backgroundColor = UIColor(hex: restaurant.userRating.ratingColor)
        cell.rating.layer.cornerRadius = 5
        cell.rating.clipsToBounds = true
        let url = URL(string: restaurant.thumb)
        Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseImage{ response in
            if (response.result.value != nil){
                cell.thumb.image = response.result.value
                cell.thumb.contentMode = .scaleToFill
                cell.thumb.layer.cornerRadius = 5
                cell.thumb.clipsToBounds = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if collections.count == 0{
                return 0
            }
            return 350
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func showAllCollections(){
        self.performSegue(withIdentifier: "collectionDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurants"{
            let restaurantsVC = segue.destination as! RestaurantsVC
            restaurantsVC.collection = selectedCollection
            restaurantsVC.location = selectedLocation
        }else{
            let allCollectionsVC = segue.destination as! AllCollectionsVC
            allCollectionsVC.collections = self.collections
            allCollectionsVC.selectedLocaiton = selectedLocation
            allCollectionsVC.selectedCollection = selectedCollection
        }
    }
}
