//
//  String.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/7/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation

extension String
{
    func jsonToDictionary() ->Dictionary<String,AnyObject>? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                return ["error":error]
            }
        }
        return nil
    }
    
    func isNil()->Bool{
        if self == "" {
            return true
        }
        return false
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}
