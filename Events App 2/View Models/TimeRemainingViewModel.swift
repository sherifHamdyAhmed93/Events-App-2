//
//  TimeRemainingViewModel.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import UIKit

class TimeRemainingViewModel{
    enum Mode{
        case cell
        case details
    }
    
    private let mode:Mode
    private let eventDate:Date?
    private let currentDate = Date()

    init(mode: Mode,eventDate:Date?) {
        self.mode = mode
        self.eventDate = eventDate
    }
    
    var remainingTime:[String]{
        guard let eventDate = eventDate else{return []}
        return currentDate.remainingTime(toDate: eventDate).components(separatedBy: ",")
    }
    
    var fontSize:CGFloat{
        switch mode {
        case .cell:
            return 28
        case .details:
            return 50
        }
    }
    
    var alignment:UIStackView.Alignment{
        switch mode {
        case .cell:
            return .trailing
        case .details:
            return .center
        }
    }
    
}
