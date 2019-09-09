//
//  Dictionary.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/7/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

extension Dictionary where Key == String{
    
    func stringFor(key:String)->String?{
        if let strValue = self[key] as? String {
            return strValue
        } else {
            return nil
        }
    }
    func intFor(key:String)->Int!{
        if let _ = self[key] {
            return self[key] as? Int
            
        }
        return nil
    }
    
    func doubleFor(key:String)->Double?{
        if let _ = self[key] {
            return self[key] as? Double
        }
        return nil
    }
    
    func dictionaryFor(key:String)->Dictionary<String,AnyObject>?{
        if let _ = self[key] {
            return self[key] as? Dictionary<String,AnyObject>
        }
        return nil
    }
    
    func arrayFor(key:String)->Array<AnyObject>?{
        if let _ = self[key] {
            return self[key] as? Array<AnyObject>
        }
        return nil
    }
}
