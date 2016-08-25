//
//  AxisLabel.swift
//  Data Viewer
//
//  Created by Gianluca Rago on 5/18/16.
//  Copyright © 2016 Ragoware LLC. All rights reserved.
//

import UIKit

class AxisLabel: UILabel {

    init(frame:CGRect, title:String) {
        super.init(frame:frame)
        self.text = title
        self.textColor = UIColor.blackColor()
        self.textAlignment = .Center
        self.font = UIFont(name:"Avenir-Heavy", size:20.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
}
