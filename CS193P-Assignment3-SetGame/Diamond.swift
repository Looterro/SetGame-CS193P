//
//  Diamond.swift
//  CS193P-Assignment3-SetGame
//
//  Created by Jakub Łata on 07/12/2022.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width
        let height = rect.height
        
        let top = CGPoint(x: center.x, y: center.y + height/2)
        let right = CGPoint(x: center.x + width/2, y: center.y)
        let bottom = CGPoint(x: center.x, y: center.y - height/2)
        let left = CGPoint(x: center.x - width/2, y: center.y)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        
        return p
    }
    
}
