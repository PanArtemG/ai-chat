//
//  Date+Extensions.swift
//  AIChat
//
//  Created by Artem Panasenko on 17.01.2025.
//

import Foundation

extension Date {
    /// Adds the specified number of days, hours, and minutes to the current date.
    func addingTimeInterval(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Date {
        let totalSeconds = (days * 24 * 60 * 60) + (hours * 60 * 60) + (minutes * 60)
        return self.addingTimeInterval(TimeInterval(totalSeconds))
    }
}
