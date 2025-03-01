//
//  Date+Extensions.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import Foundation

extension Date{
    func remainingTime(toDate:Date)->String{
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day]
        componentsFormatter.unitsStyle = .full
        return componentsFormatter.string(from: self, to: toDate) ?? ""
    }
}
