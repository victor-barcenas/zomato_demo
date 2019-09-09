//
//  CollectionsVC.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation
import UIKit

class CollectionsVC:UIViewController{
    var selectedLocation:Location!
    var locationNav:LocationNav!
    let restClient = RESTClient()
    var collections:Array<Collection> = Array()
    
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
                //print(response!)
                self.setCollections(response: response as! Dictionary<String,AnyObject>)
            }
        }
    }
    
    func setCollections(response:Dictionary<String,AnyObject>){
        let collectionsArr = response.arrayFor(key: "collections")!
        for item in collectionsArr{
            let collectionDict = item["collection"] as! Dictionary<String, AnyObject>
            print(collectionDict)
            collections.append(Collection(collectionDict))
        }
        
    }
    @objc func showLocations(){
        navigationController?.popViewController(animated: true)
    }
}
