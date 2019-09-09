//
//  Constants.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/7/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

struct Constants{
    
    static let apiKey = "535c166c48b98c0ef4d5d2d52e23f6f7"
    static let server = "https://developers.zomato.com/"
    static let api = "api/v2.1/"
    
    struct endPoints{
        static let categories = server + api + "categories"
        static let cities = server + api + "cities"
        static let collections = server + api + "collections"
        static let cuisines = server + api + "cuisines"
        static let establishments = server + api + "establishments"
        static let geocode = server + api + "geocode"
        static let locationDetails = server + api + "location_details"
        static let locations = server + api + "locations"
        static let dailymenu = server + api + "dailymenu"
        static let restaurant = server + api + "restaurant"
        static let reviews = server + api + "reviews"
        static let search = server + api + "search"
    }
    
}
