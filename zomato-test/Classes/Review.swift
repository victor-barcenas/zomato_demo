//
//  Review.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class Review{
    private var _rating:Int!
    private var _id:Int!
    private var _reviewText:String!
    private var _ratingColor:String!
    private var _ratingText:String!
    private var _timestamp:Double!
    private var _likes:Int!
    private var _userName:String!
    private var _profileImage:String!
    
    var rating:Int{
        get{return _rating}
        set{_rating = newValue}
    }
    
    var id:Int{
        get{return _id}
        set{_id = newValue}
    }
    
    var reviewText:String{
        get{return _reviewText}
        set{_reviewText = newValue}
    }
    
    var ratingColor:String{
        get{return _ratingColor}
        set{_ratingColor = newValue}
    }
    
    var ratingText:String{
        get{return _ratingText}
        set{_ratingText = newValue}
    }
    
    var timestamp:Double{
        get{return _timestamp}
        set{_timestamp = newValue}
    }
    
    var likes:Int{
        get{return _likes}
        set{_likes = newValue}
    }
    
    var userName:String{
        get{return _userName}
        set{_userName = newValue}
    }
    
    var profileImage:String{
        get{return _profileImage}
        set{_profileImage = newValue}
    }
    
    init(_ dictionary:Dictionary<String,AnyObject>){
        let review = dictionary.dictionaryFor(key: "review")
        _rating = review!.intFor(key: "rating")
        _ratingText = review!.stringFor(key: "rating_text")
        _reviewText = review!.stringFor(key: "review_text")
        _id = review!.intFor(key: "id")
        _ratingColor = review!.stringFor(key: "rating_color")
        _timestamp = review!.doubleFor(key: "timestamp")
        _likes = review!.intFor(key: "likes")
        let user = review!.dictionaryFor(key: "user")
        _userName = user!.stringFor(key: "name")
        _profileImage = user?.stringFor(key: "profile_image")
    }
}
