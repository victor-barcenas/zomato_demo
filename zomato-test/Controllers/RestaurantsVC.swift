//
//  RestaurantsVC.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/9/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit

class RestaurantsVC:UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var reusableTableView: ReusableTableView!
    let restClient = RESTClient()
    var collection:Collection!
    var location:Location!
    var restaurants:Array<Restaurant> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Restaurants"
        self.getRestaurants()
    }
    
    func getRestaurants(){
        restClient.url = Constants.endPoints.search
        restClient.requestMethod = .get
        restClient.headers = ["user-key":Constants.apiKey]
        restClient.params = ["entity_id":location.id, "entity_type":"city",
                             "collection_id":collection.id] as Dictionary<String, AnyObject>
        restClient.makeRequest { (response, error) in
            if error != nil{
                print(error!)
            }else{
                self.setRestaurants(response: response as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func setRestaurants(response:Dictionary<String,AnyObject>){
        let restaurantArr = response.arrayFor(key: "restaurants")!
        for item in restaurantArr{
            let restaurantDict = item["restaurant"] as! Dictionary<String, AnyObject>
            print(restaurantDict)
            restaurants.append(Restaurant(restaurantDict))
        }
        reusableTableView = ReusableTableView(tableView, restaurants)
        
    }
}
