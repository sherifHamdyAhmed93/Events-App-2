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
    
    static func loadEventImage(imageName:String , imageData:Data?, completion:@escaping(_ image:UIImage?)->Void){
        if let cachedImage =  CacheManager.shared.getObject(key: imageName) as? UIImage{
            completion(cachedImage)
        }else{
            DispatchQueue.global().async {
                guard let data = imageData , let eventImage = UIImage(data: data) else{
                    completion(nil)
                    return
                }
                CacheManager.shared.saveObject(key: imageName, object: eventImage)
                completion(eventImage)
            }
        }
    }
    
    
}
