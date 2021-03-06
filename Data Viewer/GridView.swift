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
    
    internal func addHorLines(maxY:CGFloat) {
        let horLineDist:CGFloat = self.frame.size.height/CGFloat(lines)
        for i in 0...lines {
            let lineView = UIView(frame:CGRect(x:0, y:CGFloat(i)*horLineDist, width:self.frame.size.width, height:lineHeight))
            lineView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            self.addSubview(lineView)
            horLineViews.append(lineView)
            createValueLabel(lineView, isVert:false, maxVal:maxY, i:i)
        }
    }
    
    internal func addVertLines(maxX:CGFloat) {
        let vertLineDist:CGFloat = self.frame.size.width/CGFloat(lines)
        for i in 0...lines {
            let lineView = UIView(frame:CGRect(x:CGFloat(i)*vertLineDist, y:0, width:lineHeight, height:self.frame.size.height))
            lineView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            self.addSubview(lineView)
            vertLineViews.append(lineView)
            createValueLabel(lineView, isVert:true, maxVal:maxX, i:i)
        }
    }
    
    internal func addBarLabels(titles:[String], barViews:[UIView]) {
        let labelHeight:CGFloat = 30.0
        for i in 0...barViews.count-1 {
            let label = UILabel(frame:CGRect(x:0, y:barViews[i].frame.size.height+(labelHeight/6), width:barViews[i].frame.size.width*2, height:labelHeight))
            label.center = CGPoint(x:barViews[i].frame.size.width/2, y:label.center.y)
            label.text = titles[i]
            label.textAlignment = .Center
            label.font = UIFont(name:"Avenir-Heavy", size:10.0)
            barViews[i].addSubview(label)
        }
    }
    
    private func createValueLabel(lineView:UIView, isVert:Bool, maxVal:CGFloat, i:Int) {
        let labelWidth:CGFloat = 40.0
        let labelHeight:CGFloat = 30.0
        var labelFrame:CGRect = CGRect(x:-labelWidth*(3/4), y:-labelWidth/3, width:labelWidth, height:labelHeight)
        if isVert {
            labelFrame = CGRect(x:-labelWidth/4, y:lineView.frame.size.height+(labelHeight/5), width:labelWidth, height:labelHeight)
        }
        let lineLabel = UILabel(frame:labelFrame)
        var value:CGFloat = CGFloat(lines-i)*(maxVal/CGFloat(lines))
        if isVert {
            value = CGFloat(i)*(maxVal/CGFloat(lines))
        }
        let displayValue:Double = Double(round(10*value)/10)
        lineLabel.text = String(displayValue)
        lineLabel.font = UIFont(name:"Avenir-Heavy", size:10.0)
        lineView.addSubview(lineLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        lines = 0
        super.init(coder:aDecoder)
    }

}
