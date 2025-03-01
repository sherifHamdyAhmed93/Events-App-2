//
//  TitleSubtitleCellViewModel.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 20/02/2025.
//

import Foundation
import UIKit

class TitleSubtitleCellViewModel{
    enum CellType{
        case text
        case date
        case image
    }
    
    let placeholder:String
    let title:String
    private(set) var subtitle:String
    let type:CellType
    private(set) var image:UIImage?

    private var onCellUpdate:(()->Void)?
    
    lazy var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        return formatter
    }()
    
    init(placeholder: String, title: String, subtitle: String,type:CellType,onCellUpdate:(()->Void)?) {
        self.placeholder = placeholder
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func updateSubtitle(_ subtitle:String){
        self.subtitle = subtitle
    }
    
    func updateDate(_ date:Date){
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate?()
    }
    
    func updateImage(_ image:UIImage){
        self.image = image
        onCellUpdate?()
    }
    
}
