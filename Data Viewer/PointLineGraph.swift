//
//  PointLineGraph.swift
//  Data Viewer
//
//  Created by Gianluca Rago on 5/17/16.
//  Copyright © 2016 Ragoware LLC. All rights reserved.
//

import UIKit

class PointLineGraph: UIView {
    
    private var points:[CGPoint]
    private var hasDrawnPoints = false
    
    private var graphContainerView:UIView
    private var pointContainerView:UIView
    private var gridView:GridView?
    
    private var pointViews:[UIView] = []
    private var lines:[UIBezierPath] = []
    
    private var margin:CGFloat = 0.0
    private var maxX:CGFloat = 0.0
    private var maxY:CGFloat = 0.0
    
    init(frame:CGRect, values:[CGPoint]) {
        self.points = values
        for point in points {
            if point.x > maxX {
                maxX = point.x
            }
            if point.y > maxY {
                maxY = point.y
            }
        }
        margin = frame.size.height/3.0
        
        graphContainerView = UIView(frame:CGRect(x:0, y:0, width:frame.size.width, height:frame.size.height))
        graphContainerView.backgroundColor = UIColor.clearColor()
        graphContainerView.layer.borderColor = UIColor.blackColor().CGColor
        graphContainerView.layer.borderWidth = 4.0
        
        pointContainerView = UIView(frame:CGRect(x:margin*(2/3), y:margin/3, width:graphContainerView.frame.size.width-margin, height:graphContainerView.frame.size.height-margin))
        pointContainerView.backgroundColor = UIColor.clearColor()
        
        super.init(frame:frame)
        self.addSubview(graphContainerView)
        graphContainerView.addSubview(pointContainerView)
    }
    
    internal func drawPoints(shouldDrawLine:Bool, lineColor:UIColor, pointColor:UIColor, shouldAnimate:Bool) {
        var relPoints:[CGPoint] = []
        if hasDrawnPoints {
            for line in lines {
                line.removeAllPoints()
            }
            lines.removeAll()
            for pointView in pointViews {
                pointView.removeFromSuperview()
            }
            pointViews.removeAll()
        }
        let pointSize:CGFloat = 6.0
        let animDuration:Double = 2.0
        let rateX:CGFloat = (pointContainerView.frame.size.width)/maxX
        let rateY:CGFloat = (pointContainerView.frame.size.height)/maxY
        for i in 0...points.count-1 {
            let relPoint:CGPoint = CGPoint(x:points[i].x*rateX, y:pointContainerView.frame.size.height-(points[i].y*rateY))
            relPoints.append(relPoint)
            let pointView = UIView(frame:CGRect(x:0, y:0, width:pointSize, height:pointSize))
            pointView.center = relPoint
            pointView.backgroundColor = pointColor
            pointView.layer.cornerRadius = pointSize/2
            pointContainerView.addSubview(pointView)
            pointViews.append(pointView)
            if shouldAnimate {
                if i > 0 {
                    pointView.alpha = 0
                    let animDelay = (animDuration/Double(points.count))*Double(NSEC_PER_SEC)
                    let animDispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(animDelay))
                    
                    dispatch_after(animDispatchTime, dispatch_get_main_queue(), {
                        UIView.animateWithDuration(animDuration/Double(self.points.count), animations: {
                            pointView.alpha = 1.0
                        })
                    })
                }
            }
        }
        if shouldDrawLine {
            let path:UIBezierPath = UIBezierPath()
            path.moveToPoint(relPoints.first!)
            for i in 0...relPoints.count-1 {
                if i != 0 {
                    path.moveToPoint(relPoints[i-1])
                    path.addLineToPoint(relPoints[i])
                }
            }
            self.lines.append(path)
            
            let pathLayer:CAShapeLayer = CAShapeLayer()
            pathLayer.frame = self.pointContainerView.bounds
            pathLayer.path = path.CGPath
            pathLayer.strokeColor = lineColor.CGColor
            pathLayer.fillColor = lineColor.CGColor
            pathLayer.lineWidth = 3.0
            pathLayer.lineJoin = kCALineJoinBevel
            pathLayer.zPosition = -1
            self.pointContainerView.layer.addSublayer(pathLayer)
            
            if shouldAnimate {
                let pathAnimation:CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
                pathAnimation.duration = animDuration
                pathAnimation.fromValue = NSNumber(float:0.0)
                pathAnimation.toValue = NSNumber(float:1.0)
                pathAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                pathLayer.addAnimation(pathAnimation, forKey:"strokeEnd")
            }
        }
        hasDrawnPoints = !hasDrawnPoints
    }
    
    internal func setAxisTitles(xAxisTitle:String, yAxisTitle:String) {
        let xAxisLabel = AxisLabel(frame:CGRect(x:0, y:self.frame.size.height-(margin/2), width:self.frame.size.width, height:margin/2), title:xAxisTitle)
        graphContainerView.addSubview(xAxisLabel)
        
        let yAxisLabel = AxisLabel(frame:CGRect(x:(margin/4)-(self.frame.size.width/2), y:(self.frame.size.height/2)-(margin/4), width:self.frame.size.width, height:margin/2), title:yAxisTitle)
        graphContainerView.addSubview(yAxisLabel)
        yAxisLabel.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    }
    
    internal func addGrid(lines:Int) {
        gridView = GridView(frame:CGRect(x:0, y:0, width:pointContainerView.frame.size.width, height:pointContainerView.frame.size.height), lines:lines)
        gridView?.addHorLines(maxX)
        gridView?.addVertLines(maxY)
        pointContainerView.addSubview(gridView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.points = []
        self.graphContainerView = UIView()
        self.pointContainerView = UIView()
        super.init(coder:aDecoder)
    }

}
