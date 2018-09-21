//
//  CustomView.swift
//  CustomChartView
//
//  Created by Marco Falanga on 21/09/18.
//  Copyright © 2018 Marco Falanga. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    @IBInspectable var slices: String = "" {
        didSet {
            values = slices.components(separatedBy: ";").map({ (string) -> CGFloat in
                CGFloat(Double(string) ?? 0)
            })
        }
    }
    
    @IBInspectable var colorsHex: String = "" {
        didSet {
            colors = colorsHex.components(separatedBy: ";").map({ (string) -> UIColor in
                UIColor(hexString: string) ?? UIColor.cyan
            })
        }
    }
    
    var colors = [UIColor]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var values = [CGFloat]() {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        self.layer.sublayers?.forEach({ (sublayer) in
            sublayer.removeFromSuperlayer()
        })
        
        var startAngleEndAngle: [(CGFloat, CGFloat)] = []
        
        for (index, value) in values.enumerated() {
            if index == 0 {
                startAngleEndAngle.append((0, 2 * .pi * value))
            }
            else {
                startAngleEndAngle.append((startAngleEndAngle[index-1].1 , (2 * .pi * value) + startAngleEndAngle[index-1].1))
            }
        }

        while colors.count < values.count {
            colors.append(UIColor.cyan)
        }
        
        for (index, value) in startAngleEndAngle.enumerated() {
            print(value)
            let shape = CAShapeLayer()
            shape.path = UIBezierPath(arcCenter: self.center, radius: (self.frame.width - lineWidth)/2, startAngle: value.0, endAngle: value.1, clockwise: true).cgPath
            shape.lineWidth = lineWidth
            shape.strokeColor = colors[index].cgColor
            shape.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(shape)
        }
    }
}
