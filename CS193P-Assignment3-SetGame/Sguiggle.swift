//
//  Sguiggle.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 07/12/2022.
//

import SwiftUI

struct Sguiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var p = Path()
        p.move(to: CGPoint(x: 104.0, y: 15.0))
        p.addCurve(to: CGPoint(x: 63.0, y: 54.0),
                   control1: CGPoint(x: 112.4, y: 36.9),
                   control2: CGPoint(x: 89.7, y: 60.8))
        p.addCurve(to: CGPoint(x: 27.0, y: 53.0),
                              control1: CGPoint(x: 52.3, y: 51.3),
                              control2: CGPoint(x: 42.2, y: 42.0))
        p.addCurve(to: CGPoint(x: 5.0, y: 40.0),
                   control1: CGPoint(x: 9.6, y: 65.6),
                   control2: CGPoint(x: 5.4, y: 58.3))
        p.addCurve(to: CGPoint(x: 36.0, y: 12.0),
                   control1: CGPoint(x: 4.6, y: 22.0),
                   control2: CGPoint(x: 19.1, y: 9.7))
        p.addCurve(to: CGPoint(x: 89.0, y: 14.0),
                   control1: CGPoint(x: 59.2, y: 15.2),
                   control2: CGPoint(x: 61.9, y: 31.5))
        p.addCurve(to: CGPoint(x: 104.0, y: 15.0),
                   control1: CGPoint(x: 95.3, y: 10.0),
                   control2: CGPoint(x: 100.9, y: 6.9))
        
        //make sure Sguiggle fits into its container
        let pRect = p.boundingRect
        
        p = p.offsetBy(dx: rect.minX - pRect.minX, dy: rect.minY - pRect.minY)
        
        let scale: CGFloat = rect.width / pRect.width
        
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        
        p = p.applying(transform)
        
        return p
            .offsetBy(dx: rect.minX - p.boundingRect.minX, dy: rect.midY - p.boundingRect.midY)
    }
    
}
