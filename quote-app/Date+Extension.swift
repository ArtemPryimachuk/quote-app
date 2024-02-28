//
//  Date+Extension.swift
//  quote-app
//
//  Created by Artem on 28.02.2024.
//

import Foundation
extension Date {

    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }

}
