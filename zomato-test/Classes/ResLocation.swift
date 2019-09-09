//
//  ResLocation.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class ResLocation{
    
    private var _address:String!
    private var _locality:String!
    private var _city:String!
    private var _cityId:Int!
    private var _latitude:Double!
    private var _longitude:Double!
    private var _zipcode:String!
    private var _localityVerbose:String!
    
    var address:String{
        get{return _address}
        set{_address = newValue}
    }
    
    var locality:String{
        get{return _locality}
        set{_locality = newValue}
    }
    
    var city:String{
        get{return _city}
        set{_city = newValue}
    }
    
    var cityId:Int{
        get{return _cityId}
        set{_cityId = newValue}
    }
    
    var latitude:Double{
        get{return _latitude}
        set{_latitude = newValue}
    }
    
    var longitude:Double{
        get{return _longitude}
        set{_longitude = newValue}
    }
    
    var zipcode:String{
        get{return _zipcode}
        set{_zipcode = newValue}
    }
    
    var localityVerbose:String{
        get{return _localityVerbose}
        set{_localityVerbose = newValue}
    }
    
    init(_ dictionary:Dictionary<String,AnyObject>){
        _address = dictionary.stringFor(key: "address")
        _locality = dictionary.stringFor(key: "locality")
        _city = dictionary.stringFor(key: "city")
        _cityId = dictionary.intFor(key: "city_id")
        _latitude = Double(dictionary.stringFor(key: "latitude")!)
        _longitude = Double(dictionary.stringFor(key: "longitude")!)
        _zipcode = dictionary.stringFor(key: "zipcode")
        _localityVerbose = dictionary.stringFor(key: "locality_verbose")
    }
}
