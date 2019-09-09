//
//  LocationNav.swift
//  zomato-test
//
//  Created by Victor Barcenas Monreal on 9/8/19.
//  Copyright © 2019 Victor Barcenas Monreal. All rights reserved.
//

import Foundation
import UIKit

class LocationNav:UIView{
    
    @IBOutlet private var contentView:UIView?
    @IBOutlet weak var lcoationName: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("LocationNav", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }
}
