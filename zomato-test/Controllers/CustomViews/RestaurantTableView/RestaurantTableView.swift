//
//  RestaurantTableView.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage

class ReusableTableView: NSObject, UITableViewDataSource, UITableViewDelegate
{
    var _tableView: UITableView
    var _tableViewData: [Restaurant]
    let _identifier = "restaurantCell"
    var parent:RestaurantsVC!
    
    init(_ tableView: UITableView, _ data: [Restaurant]){
        _tableViewData = data
        _tableView = tableView
        super.init()
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: _identifier)
        _tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _identifier, for: indexPath) as! RestaurantCell
        let restaurant = _tableViewData[indexPath.row]
        cell.name.text = restaurant.name
        cell.establishment.text = restaurant.establishment + " - " + restaurant.cuisines
        cell.cost.text = "$\(restaurant.averageCostForTwo) for two people (approx.)"
        cell.location.text = restaurant.location.address
        cell.rating.text = restaurant.userRating.aggregateRating
        cell.rating.backgroundColor = UIColor(hex: restaurant.userRating.ratingColor)
        cell.rating.layer.cornerRadius = 5
        cell.rating.clipsToBounds = true
        let url = URL(string: restaurant.thumb)
        if (url != nil) {
            Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseImage{ response in
                if (response.result.value != nil){
                    cell.thumb.image = response.result.value
                    cell.thumb.contentMode = .scaleToFill
                }
            }
        }
        cell.thumb.layer.cornerRadius = 5
        cell.thumb.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        parent.selectedInex = indexPath.row
        parent.performSegue(withIdentifier: "restDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
