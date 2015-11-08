//
//  CircleView.swift
//  Timer
//
//  Created by Etay Luz on 11/7/15.
//  Copyright © 2015 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
  
  var circleLayer: CAShapeLayer!
  
  override func drawRect(rect: CGRect) {
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
    
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
    
        //I'm going to change this in the ViewController that uses this. Not the best way, I know but alas.
        circleLayer.strokeColor = UIColor.whiteColor().CGColor
    
        //You probably want to change this width
        circleLayer.lineWidth = 5.0;
    
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0
    
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
  }
}

