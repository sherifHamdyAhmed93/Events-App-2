//
//  UIImage+Extension.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import UIKit

extension UIImage{
    func sameAspectRatio(newHeight:CGFloat)->UIImage{
        let scale = newHeight/self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
