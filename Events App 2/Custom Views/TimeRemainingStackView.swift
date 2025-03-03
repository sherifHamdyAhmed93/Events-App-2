//
//  TimeRemainingStackView.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import UIKit

class TimeRemainingStackView:UIStackView{
    private var timeRemainingLabels = [UILabel(),UILabel(),UILabel(),UILabel()]
    
    func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        timeRemainingLabels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
    
    func setData(timeRemainingViewModel:TimeRemainingViewModel){
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: timeRemainingViewModel.fontSize, weight: .medium)
            $0.textColor = .white
            $0.text = ""
        }
        self.alignment = timeRemainingViewModel.alignment
        
        timeRemainingViewModel.remainingTime.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
    }
    
}
