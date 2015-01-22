//
//  DrawView.swift
//  DrawWithFriends
//
//  Created by Sean Viswanathan on 1/4/15.
//  Copyright (c) 2015 Sean Viswanathan. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var lines: [Lines] = []
    var lastPoint: CGPoint!
    
   /* required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // initilization code
        
    }*/
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastPoint = touches.anyObject()?.locationInView(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var newPoint = touches.anyObject()?.locationInView(self)
        lines.append(Lines(start: lastPoint!, end: newPoint!))
        lastPoint = newPoint
        
        //let messageData = NSJSONSerialization.dataWithJSONObject(lines, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        
        
        self.setNeedsDisplay()
        
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0)
        CGContextSetLineWidth(context, 5.0)
        CGContextStrokePath(context)
    }

}
