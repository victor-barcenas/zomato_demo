//
//  Restaurant.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class Restaurant{
    
    private var _name:String!
    private var _url:String!
    private var _cuisines:String!
    private var _timings:String!
    private var _averageCostForTwo:Int!
    private var _priceRange:Int!
    private var _currency:String!
    private var _highlights:[String]!
    private var _userRating:UserRating!
    private var _reviews:[Review] = Array()
    private var _featuredImage:String!
    private var _thumb:String!
    private var _phoneNumbers:String!
    private var _establishment:String!
    private var _location:ResLocation!
    
    var name:String{
        get{return _name}
        set{_name = newValue}
    }
    
    var url:String{
        get{return _url}
        set{_url = newValue}
    }
    
    var cuisines:String{
        get{return _cuisines}
        set{_cuisines = newValue}
    }
    
    var timings:String{
        get{return _timings}
        set{_timings = newValue}
    }
    
    var averageCostForTwo:Int{
        get{return _averageCostForTwo}
        set{_averageCostForTwo = newValue}
    }
    
    var priceRange:Int{
        get{return _priceRange}
        set{_priceRange = newValue}
    }
    
    var currency:String{
        get{return _currency}
        set{_currency = newValue}
    }
    
    var highlights:[String]{
        get{return _highlights}
        set{_highlights = newValue}
    }
    
    var userRating:UserRating{
        get{return _userRating}
        set{_userRating = newValue}
    }
    
    var reviews:[Review]{
        get{return _reviews}
        set{_reviews = newValue}
    }
    
    var featuredImage:String{
        get{return _featuredImage}
        set{_featuredImage = newValue}
    }
    
    var thumb:String{
        get{return _thumb}
        set{_thumb = newValue}
    }
    
    var phoneNumbers:String{
        get{return _phoneNumbers}
        set{_phoneNumbers = newValue}
    }
    
    var establishment:String{
        get{return _establishment}
        set{_establishment = newValue}
    }
    
    var location:ResLocation{
        get{return _location}
        set{_location = newValue}
    }
    
    init(_ dictionary:Dictionary<String,AnyObject>){
        _name = dictionary.stringFor(key: "name")
        _url = dictionary.stringFor(key: "url")
        _cuisines = dictionary.stringFor(key: "cuisines")
        _timings = dictionary.stringFor(key: "timings")
        _averageCostForTwo = dictionary.intFor(key: "average_cost_for_two")
        _priceRange = dictionary.intFor(key: "price_range")
        _currency = dictionary.stringFor(key: "currency")
        _highlights = dictionary.arrayFor(key: "highlights") as? [String]
        _userRating = UserRating(dictionary.dictionaryFor(key: "user_rating")!)
        let reviewsDict = dictionary.dictionaryFor(key: "all_reviews")
        let reviewArr:Array<Dictionary<String,AnyObject>> = reviewsDict!.arrayFor(key: "reviews")! as! Array<Dictionary<String, AnyObject>>
        for review in reviewArr{
            _reviews.append(Review(review))
        }
        _featuredImage = dictionary.stringFor(key: "thumb")
        _thumb = dictionary.stringFor(key: "featured_image")
        _phoneNumbers = dictionary.stringFor(key: "phone_numbers")
        let establishments = dictionary.arrayFor(key: "establishment") as? [String]
        if establishments?.count != 0{
            _establishment = establishments![0]
        }else{
            _establishment = ""
        }
        
        _location = ResLocation(dictionary.dictionaryFor(key: "location")!)
    }
}


