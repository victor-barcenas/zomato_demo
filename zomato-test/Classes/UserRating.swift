//
//  UserRating.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class UserRating{
    private var _aggregateRating:String!
    private var _ratingText:String!
    private var _ratingColor:String!
    private var _votes:Int!
    
    var aggregateRating:String{
        get{
            if _aggregateRating == nil{
                return ""
            }
            return _aggregateRating
        }
        set{_aggregateRating = newValue}
    }
    
    var ratingText:String{
        get{return _ratingText}
        set{_ratingText = newValue}
    }
    
    var ratingColor:String{
        get{return _ratingColor}
        set{_ratingColor = newValue}
    }
    
    var votes:Int{
        get{return _votes}
        set{_votes = newValue}
    }
    
    init(_ dictionary:Dictionary<String,AnyObject>){
        _aggregateRating = dictionary.stringFor(key: "aggregate_rating")
        _ratingText = dictionary.stringFor(key: "rating_text")
        _ratingColor = dictionary.stringFor(key: "rating_color")
        _votes = dictionary.intFor(key: "votes")
    }
}
