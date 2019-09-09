//
//  RESTClient.swift
//  RecordAssistance
//
//  Created by Victor Alfonso Barcenas Monreal on 7/28/17.
//  Copyright © 2017 Victor Alfonso Barcenas Monreal. All rights reserved.
//

import UIKit
import Alamofire

class RESTClient{
    
    private var _params:Dictionary<String,AnyObject>!
    private var _headers:Dictionary<String,String>!
    private var _url:String!
    private var _requestMethod:HTTPMethod! = .get
    private var _encoding:ParameterEncoding = URLEncoding.default
    private var sessionManager:Alamofire.SessionManager!
    private var networkManager:Alamofire.NetworkReachabilityManager!
    let userDefaults = UserDefaults.standard
    
    var params:Dictionary<String,AnyObject>!{
        get{
            return _params
        }
        set{
            _params = newValue
        }
    }
    
    var headers:Dictionary<String,String>!{
        get{
            return _headers
        }
        set{
            _headers = newValue
        }
    }
    
    var url:String{
        get{
            return _url
        }
        set{
            _url = newValue
        }
    }
    
    var requestMethod:HTTPMethod!{
        get{
            return _requestMethod
        }
        set{
            _requestMethod = newValue
        }
    }
    
    var encoding:ParameterEncoding{
        get{
            return _encoding
        }
        set{
            _encoding = newValue
        }
    }
    
    init(){
        sessionManager = SessionManager()
        sessionManager.session.configuration.timeoutIntervalForRequest = 30
        sessionManager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        networkManager = Alamofire.NetworkReachabilityManager()!
    }
    
    
    func makeRequest(completion: @escaping (_ response:Any?, _ error:Error?) -> Void) {
        if isNetworkValidAndAvailable(){
            sessionManager.request(url, method: requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON {
                response in
                if response.result.isFailure {
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        print("Failure Response: \(json!)")
                    }
                    completion(nil,response.error)
                }else{
                    completion(response.result.value!,nil)
                }
            }
        }else{
            completion(nil,NSError(domain: "No network available", code: 500, userInfo: nil))
        }
    }
    
    func displayErrorMessage(_ error:NSError, onViewController viewcontroller:UIViewController){
        if error.code == 500{
            print("networkError")
        }else{
            print("unexpectedError")
        }
    }
    
    func isNetworkValidAndAvailable()->Bool{
        var isValidAndAvailable = false
        
        if networkManager.isReachable{
            if wifiEnabled() && mobileConnEnabled(){
                isValidAndAvailable = true
            }else if networkManager.isReachableOnEthernetOrWiFi{
                if wifiEnabled(){
                    isValidAndAvailable = true
                }
            }else if networkManager.isReachableOnWWAN{
                if mobileConnEnabled(){
                    isValidAndAvailable = true
                }
            }
        }
        return isValidAndAvailable
    }
    
    private func wifiEnabled()->Bool{
        //return userDefaults.bool(forKey: "WiFi-Enabled")
        return true
    }
    
    private func mobileConnEnabled()->Bool{
        //return userDefaults.bool(forKey: "Mobile-Enabled")
        return true
    }
}



