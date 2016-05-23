//
//  BarGraph.swift
//  Data Viewer
//
//  Created by Gianluca Rago on 5/18/16.
//  Copyright © 2016 Ragoware LLC. All rights reserved.
//

import UIKit

class BarGraph: UIView {
    
    private var valueDict:[String:CGFloat]
    
    private var graphContainerView:UIView
    private var barContainerView:UIView
    private var gridView:GridView?
    
    private var margin:CGFloat = 0.0
    private var maxY:CGFloat = 0.0
    
    init(frame:CGRect, valueDict:[String:CGFloat]) {
        self.valueDict = valueDict
        for value in valueDict {
            if value.1 > maxY {
                maxY = value.1
            }
        }
        margin = frame.size.height/3.0
        
        graphContainerView = UIView(frame:CGRect(x:0, y:0, width:frame.size.width, height:frame.size.height))
        graphContainerView.backgroundColor = UIColor.clearColor()
        graphContainerView.layer.borderColor = UIColor.blackColor().CGColor
        graphContainerView.layer.borderWidth = 4.0
        
        barContainerView = UIView(frame:CGRect(x:margin*(2/3), y:margin/3, width:graphContainerView.frame.size.width-margin, height:graphContainerView.frame.size.height-margin))
        barContainerView.backgroundColor = UIColor.clearColor()
        
        super.init(frame:frame)
        self.addSubview(graphContainerView)
        graphContainerView.addSubview(barContainerView)
    }
    
    internal func drawBars(shouldAnimate:Bool) {
        let animDuration = 0.8
        let distX:CGFloat = barContainerView.frame.size.width/10.0
        let rateX:CGFloat = barContainerView.frame.size.height/maxY
        let width:CGFloat = (barContainerView.frame.size.width-(CGFloat(valueDict.count)*distX))/CGFloat(valueDict.count)
        var i = 0
        for value in valueDict {
            let finalHeight:CGFloat = value.1*rateX
            var startHeight:CGFloat = finalHeight
            if shouldAnimate {
                startHeight = 0.0
            }
            let barView = UIView(frame:CGRect(x:((distX+width)*CGFloat(i))+(distX/2), y:barContainerView.frame.size.height, width:width, height:startHeight))
            barView.backgroundColor = UIColor.blueColor()
            barContainerView.addSubview(barView)
            i+=1
            if shouldAnimate {
                UIView.animateWithDuration(animDuration, animations: {
                    barView.frame = CGRect(x:barView.frame.origin.x, y:self.barContainerView.frame.size.height-finalHeight, width:barView.frame.size.width, height:finalHeight)
                })
            }
        }
    }
    
    internal func setAxisTitles(xAxisTitle:String, yAxisTitle:String) {
        let xAxisLabel = AxisLabel(frame:CGRect(x:0, y:self.frame.size.height-(margin/2), width:self.frame.size.width, height:margin/2), title:xAxisTitle)
        graphContainerView.addSubview(xAxisLabel)
        
        let yAxisLabel = AxisLabel(frame:CGRect(x:(margin/4)-(self.frame.size.width/2), y:(self.frame.size.height/2)-(margin/4), width:self.frame.size.width, height:margin/2), title:yAxisTitle)
        graphContainerView.addSubview(yAxisLabel)
        yAxisLabel.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    }
    
    internal func addGrid(lines:Int) {
        gridView = GridView(frame:CGRect(x:0, y:0, width:barContainerView.frame.size.width, height:barContainerView.frame.size.height), lines:lines)
        gridView?.addHorLines(maxY)
        var titles:[String] = []
        for value in valueDict {
            titles.append(value.0)
        }
        gridView?.addBarLabels(titles)
        barContainerView.addSubview(gridView!)
    }

    required init?(coder aDecoder: NSCoder) {
        valueDict = [:]
        graphContainerView = UIView()
        barContainerView = UIView()
        super.init(coder:aDecoder)
    }
    
}
