//
//  Collection.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

class Collection{
    
    private var _id:Int!
    private var _description:String!
    private var _imageUrl:String!
    private var _resCount:Int!
    private var _shareUrl:String!
    private var _title:String!
    private var _url:String!
    
    var id:Int{
        get{return _id}
        set{_id = newValue}
    }
    
    var description:String{
        get{return _description}
        set{_description = newValue}
    }
    
    var imageUrl:String{
        get{return _imageUrl}
        set{_imageUrl = newValue}
    }
    
    var resCount:Int{
        get{return _resCount}
        set{_resCount = newValue}
    }
    
    var shareUrl:String{
        get{return _shareUrl}
        set{_shareUrl = newValue}
    }
    var title:String{
        get{return _title}
        set{_title = newValue}
    }
    
    var url:String{
        get{return _url}
        set{_url = newValue}
    }
    
    init(_ dictionary:Dictionary<String,AnyObject>){
        _id = dictionary.intFor(key: "collection_id")
        _description = dictionary.stringFor(key: "description")
        _imageUrl = dictionary.stringFor(key: "image_url")
        _resCount = dictionary.intFor(key: "res_count")
        _shareUrl = dictionary.stringFor(key: "share_url")
        _title = dictionary.stringFor(key: "title")
        _url = dictionary.stringFor(key: "url")
    }
}
