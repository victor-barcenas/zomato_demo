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
    var activiyIndicator:ActivityIndicatorView!
    var selectedInex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Restaurants"
        activiyIndicator = ActivityIndicatorView(center: self.view.center)
        activiyIndicator.view.backgroundColor = UIColor(hex: "BA3435")
        self.getRestaurants()
    }
    
    func getRestaurants(){
        restClient.url = Constants.endPoints.search
        restClient.requestMethod = .get
        restClient.headers = ["user-key":Constants.apiKey]
        restClient.params = ["entity_id":location.id, "entity_type":"city",
                             "collection_id":collection.id] as Dictionary<String, AnyObject>
        activiyIndicator.startAnimating()
        self.view.addSubview(activiyIndicator!.getViewActivityIndicator())
        restClient.makeRequest { (response, error) in
            self.activiyIndicator.stopAnimating()
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
        reusableTableView.parent = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let restDetailVC = segue.destination as! RestaurantDetail
        restDetailVC.restaurant = restaurants[selectedInex]
    }
}
