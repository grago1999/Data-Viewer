//
//  GridView.swift
//  Data Viewer
//
//  Created by Gianluca Rago on 5/18/16.
//  Copyright © 2016 Ragoware LLC. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    private var lines:Int
    
    private var horLineViews:[UIView] = []
    private var vertLineViews:[UIView] = []
    
    private let lineHeight:CGFloat = 2.0
    
    init(frame:CGRect, lines:Int) {
        self.lines = lines
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.zPosition = -1
    }
    
    internal func addHorLines() {
        let horLineDist:CGFloat = self.frame.size.height/CGFloat(lines)
        for i in 0...lines {
            let lineView = UIView(frame:CGRect(x:0, y:CGFloat(i)*horLineDist, width:self.frame.size.width, height:lineHeight))
            lineView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            self.addSubview(lineView)
            horLineViews.append(lineView)
        }
    }
    
    internal func addVertLines() {
        let vertLineDist:CGFloat = self.frame.size.width/CGFloat(lines)
        for i in 0...lines {
            let lineView = UIView(frame:CGRect(x:CGFloat(i)*vertLineDist, y:0, width:lineHeight, height:self.frame.size.height))
            lineView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            self.addSubview(lineView)
            vertLineViews.append(lineView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        lines = 0
        super.init(coder:aDecoder)
    }

}
