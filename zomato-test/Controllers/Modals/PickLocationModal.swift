//
//  PickLocationModal.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation
import UIKit

class PickLocationModal:UIViewController{
    
    @IBOutlet weak var pickContainer: UIView!
    @IBOutlet weak var pickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickButton.layer.borderColor = UIColor(red:0.28, green:0.33, blue:0.39, alpha:1.0).cgColor
        pickButton.layer.borderWidth = 0.5;
        pickButton.layer.cornerRadius = 5
        
        pickContainer.layer.cornerRadius = 5
        
    }
    
    @IBAction func pickAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
