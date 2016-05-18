//
//  ViewController.swift
//  Data Viewer
//
//  Created by Gianluca Rago on 5/16/16.
//  Copyright © 2016 Ragoware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pointGraph = PointLineGraph(frame:CGRect(x:0, y:0, width:screenWidth, height:300.0), values:[CGPointZero, CGPoint(x:10.0, y:10.0), CGPoint(x:10.0, y:20.0), CGPoint(x:20.0, y:20.0), CGPoint(x:30.0, y:30.0), CGPoint(x:40.0, y:40.0), CGPoint(x:50.0, y:50.0), CGPoint(x:24.0, y:46.0), CGPoint(x:37.0, y:62.3)])
        pointGraph.center = self.view.center
        pointGraph.setAxisTitles("X Axis", yAxisTitle:"Y Axis")
        pointGraph.addGrid(10)
        self.view.addSubview(pointGraph)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

