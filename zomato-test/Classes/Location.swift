//
//  Location.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/7/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class Location{
    
    private var _countryFlag:String!
    private var _countryId:Int!
    private var _countryName:String!
    private var _id:Int!
    private var _name:String!
    private var _stateCode:String!
    private var _stateId:Int!
    private var _stateName:String!
    
    var countryFlag:String{
        get{return _countryFlag}
        set{_countryFlag = newValue}
    }
    
    var countryId:Int{
        get{return _countryId}
        set{_countryId = newValue}
    }
    
    var countryName:String{
        get{return _countryName}
        set{_countryName = newValue}
    }
    
    var id:Int{
        get{return _id}
        set{_id = newValue}
    }
    
    var name:String{
        get{return _name}
        set{_name = newValue}
    }
    
    var stateCode:String{
        get{return _stateCode}
        set{_stateCode = newValue}
    }
    
    var stateId:Int{
        get{return _stateId}
        set{_stateId = newValue}
    }
    
    var stateName:String{
        get{return _stateName}
        set{_stateName = newValue}
    }
    
    init(with dictionary:Dictionary<String,AnyObject>){
        _countryFlag = dictionary.stringFor(key: "country_flag_url")
        _countryName = dictionary.stringFor(key: "country_name")
        _countryId = dictionary.intFor(key: "country_id")
        _id = dictionary.intFor(key: "id")
        _name = dictionary.stringFor(key: "name")
        _stateCode = dictionary.stringFor(key: "state_code")
        _stateId = dictionary.intFor(key: "state_id")
        _stateName = dictionary.stringFor(key: "state_name")
    }
}
