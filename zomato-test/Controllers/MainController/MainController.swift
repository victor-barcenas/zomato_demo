//
//  ViewController.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/7/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import UIKit
import Alamofire

class MainController: UITableViewController, UISearchBarDelegate{
    
    var searchController: UISearchController!
    let restClient = RESTClient()
    var locations:Array<Location> = []
    var selectedLocation:Location!
    var activiyIndicator:ActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.navigationItem.title = "Locations"
        self.performSegue(withIdentifier: "pickModal", sender: self)
        activiyIndicator = ActivityIndicatorView(center: self.view.center)
        activiyIndicator.view.backgroundColor = UIColor(hex: "BA3435")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        restClient.url = Constants.endPoints.cities
        restClient.requestMethod = .get
        restClient.headers = ["user-key":Constants.apiKey]
        restClient.params = ["q":searchBar.text] as Dictionary<String, AnyObject>
        activiyIndicator.startAnimating()
        self.view.addSubview(activiyIndicator!.getViewActivityIndicator())
        restClient.makeRequest { (response, error) in
            self.activiyIndicator.stopAnimating()
            if error != nil{
                print(error!)
            }else{
                //print(response!)
                self.setLocationsWith(response as! Dictionary<String, AnyObject>)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearLocations()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0{
            clearLocations()
        }
    }
    
    func clearLocations(){
        locations.removeAll()
        tableView.reloadData()
    }
    
    func setLocationsWith(_ response:Dictionary<String, AnyObject>){
        let locationSuggestions = response.arrayFor(key: "location_suggestions")
        if locationSuggestions!.count > 0{
            for location in locationSuggestions!{
                locations.append(Location(with: location as! Dictionary<String, AnyObject>))
            }
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell:LocationCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCell
        let location = locations[indexPath.row]
        locationCell.locationName.text = location.name.components(separatedBy: ",")[0]
        let locationState = location.stateCode + ", " + location.countryName
        locationCell.locationState.text = locationState
        return locationCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedLocation = locations[indexPath.row]
        self.performSegue(withIdentifier: "collections", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collections"{
            let collectionsVC = segue.destination as! CollectionsVC
            collectionsVC.selectedLocation = selectedLocation
            searchController.searchBar.text = ""
            clearLocations()
        }else if segue.identifier == "pickModal"{
            let modal = segue.destination as! PickLocationModal
            modal.modalPresentationStyle = .overFullScreen
        }
        
    }
}
