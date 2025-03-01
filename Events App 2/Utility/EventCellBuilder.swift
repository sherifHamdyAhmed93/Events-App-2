//
//  EventCellBuilder.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 25/02/2025.
//

import Foundation

class EventCellBuilder{
    func buildCell(_ cellType:TitleSubtitleCellViewModel.CellType , onUpdateCell:(()->Void)? = nil)->TitleSubtitleCellViewModel{
        switch cellType {
        case .text:
            return TitleSubtitleCellViewModel(placeholder: "Add a name", title: "name", subtitle: "", type: .text, onCellUpdate: onUpdateCell)
        case .date:
            return TitleSubtitleCellViewModel(placeholder: "Select Date", title: "Date", subtitle: "", type: .date, onCellUpdate: onUpdateCell)
        case .image:
            return TitleSubtitleCellViewModel(placeholder: "", title: "Background", subtitle: "", type: .image, onCellUpdate: onUpdateCell)
        }
    }
}
