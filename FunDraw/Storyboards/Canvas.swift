//
//  Canvas.swift
//  FunDraw
//
//  Created by Seth Danner on 1/14/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    fileprivate var lines = [Line]()
    
    // public functions
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        // Custom Drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Lines setup
        // dummy data
        //        let startPoint = CGPoint(x: 0, y: 0)
        //        let endPoint = CGPoint(x: 100, y: 100)
        //
        //        context.move(to: startPoint)
        //        context.addLine(to: endPoint)
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth ))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    // let's ditch this line
    //    var line = [CGPoint]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, strokeWidth: strokeWidth, points: []))
    }
    
    // track finger as it moves across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        //        print(point)
        
        // To make sure that the last line gets properly added
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        //        line.append(point)
        
        setNeedsDisplay()
    }
}

