//
//  UIView+Extensions.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import UIKit

enum Edge:Int,CaseIterable{
    case top = 0
    case bottom
    case left
    case right
}

extension UIView{
    func pinSubviewsToSuperView(edges:[Edge] = Edge.allCases,constant:CGFloat = 0){
        guard let superview else{return}
        
        edges.forEach {
            switch $0 {
            case .top:
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .left:
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            case .right:
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            }
        }
        
    }
}
