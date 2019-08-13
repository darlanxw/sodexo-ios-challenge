//
//  GradientView.swift
//  TraktApp
//
//  Created by objective on 13/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet{
            calculatePoints()
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet{
            calculatePoints()
            updateView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet {
            calculatePoints()
            updateView()
        }
    }
    
    @IBInspectable var useShadow: Bool = false {
        didSet {
            calculatePoints()
            updateView()
        }
    }
    
    @IBInspectable var angle: CGFloat = 180 {
        didSet {
            calculatePoints()
            updateView()
        }
    }        
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
        
        layer.startPoint = startPoint
        layer.endPoint = endPoint
        
        if (useShadow) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowRadius = 6
            layer.cornerRadius = 6
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    private func calculatePoints() {
        
        var ang = (-angle).truncatingRemainder(dividingBy: 360)
        
        if ang < 0 {
            ang = 360 + ang + getAngleByOrientation()
        }
        
        let n: CGFloat = 0.5
        
        switch ang {
            
        case 0...45, 315...360:
            let a = CGPoint(x: 0, y: n * tanx(ang) + n)
            let b = CGPoint(x: 1, y: n * tanx(-ang) + n)
            startPoint = a
            endPoint = b
            
        case 45...135:
            let a = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            let b = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            startPoint = a
            endPoint = b
            
        case 135...225:
            let a = CGPoint(x: 1, y: n * tanx(-ang) + n)
            let b = CGPoint(x: 0, y: n * tanx(ang) + n)
            startPoint = a
            endPoint = b
            
        case 225...315:
            let a = CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
            let b = CGPoint(x: n * tanx(ang - 90) + n, y: 1)
            startPoint = a
            endPoint = b
            
        default:
            let a = CGPoint(x: 0, y: n)
            let b = CGPoint(x: 1, y: n)
            startPoint = a
            endPoint = b
            
        }
    }
    
    private func tanx(_ 𝜽: CGFloat) -> CGFloat {
        return tan(𝜽 * CGFloat.pi / 180)
    }
    
    private func getAngleByOrientation() -> CGFloat {
        if (isHorizontal) {
            return 180
        }
        return 90
    }
}
